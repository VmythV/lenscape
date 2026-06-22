# 镜界 Lenscape 技术架构

> 配套文档：[产品需求](prd.md) · [可行性评估](feasibility.md) · [数据模型与推荐规则](data-model.md) · [LLM 接口契约与 Prompt](llm-spec.md)

## 1. 设计原则

1. **内容为本，AI 增值**：核心闭环（选风格 → 选人物 → 选场景 → 看图文指导）由本地静态模板驱动，保证零延迟、可离线、稳定可控；LLM 只做风格推荐与文案润色等「增值」，永远可降级到静态文案。
2. **客户端不持密钥**：任何 LLM API Key 都不进客户端，统一由后端代理保管。
3. **provider 无关**：业务代码只依赖统一的 LLM 抽象接口，具体接 Anthropic 还是 OpenAI 协议由配置决定，可热切换、可多活降级。
4. **窄边界**：严格守住「只做拍摄前指导」的产品边界，架构上不预留拍照、上传、评分、存储成片的链路。
5. **先验证后扩展**：第一版不做账号、后台、热更新；数据随版本发布。

## 2. 系统总览

```text
┌─────────────────────────────────────────┐
│            Flutter 客户端 (iOS/Android)    │
│                                          │
│  UI 层    选择流程 / 指导页 / 收藏 / 历史    │
│  状态层   Riverpod (provider/notifier)     │
│  领域层   推荐引擎(规则) · 模板仓库 · 收藏仓库 │
│  数据层   本地静态 JSON  +  本地持久化(Hive) │
│           └── 静态图片资产(assets)          │
└───────────────┬──────────────────────────┘
                │  HTTPS (仅 LLM 增值能力)
                ▼
┌─────────────────────────────────────────┐
│           后端代理 (BFF, 无状态)           │
│  路由   /v1/style-recommend               │
│         /v1/guidance-copy                 │
│  能力   鉴权·限流·缓存·参数校验·降级兜底     │
│  ┌─────────────────────────────────────┐ │
│  │   LLM Provider 统一抽象 (工厂)        │ │
│  │   ┌───────────────┐ ┌─────────────┐ │ │
│  │   │ AnthropicImpl │ │ OpenAIImpl  │ │ │
│  │   │ (Messages API)│ │(Chat Compl.)│ │ │
│  │   └───────┬───────┘ └──────┬──────┘ │ │
│  └──────────┼────────────────┼─────────┘ │
└─────────────┼────────────────┼───────────┘
              ▼                ▼
        Anthropic API    OpenAI / 兼容协议端点
                         (OpenAI / 国产兼容 / vLLM 本地)
```

要点：

- **客户端可独立工作**：不调后端也能完成全部核心闭环，后端只在用户主动触发「智能推荐风格」或「生成个性化文案」时被调用。
- **后端无状态**：不存用户数据，只做转发、校验、缓存与降级，便于水平扩展。

## 3. Flutter 客户端架构

### 3.1 分层

| 层 | 职责 | 关键组件 |
| ---- | ---- | ---- |
| UI 层 | 页面与组件，仅渲染与交互 | 首页、风格页、人物类型页、场景页、指导页、收藏/历史 |
| 状态层 | 页面状态、流程编排 | Riverpod `Notifier` / `AsyncNotifier` |
| 领域层 | 业务规则，无 UI/IO 依赖 | `RecommendationEngine`（规则匹配）、`TemplateRepository`、`FavoriteRepository`、`LlmGateway`（调用后端） |
| 数据层 | 数据读写 | 静态 JSON 加载器、`Hive` 本地库、`assets` 图片 |

### 3.2 推荐技术选型

| 关注点 | 选型 | 理由 |
| ---- | ---- | ---- |
| 框架 | Flutter (stable) | 已确认 |
| 状态管理 | Riverpod | 可测试、编译期安全、依赖注入友好 |
| 路由 | go_router | 声明式、深链友好 |
| 本地持久化 | Hive | 轻量 KV，存收藏/历史/缓存，无需 SQL |
| 网络 | dio | 拦截器、超时、重试方便 |
| 序列化 | freezed + json_serializable | 不可变模型、模式安全 |
| 国际化 | flutter_intl | 第一版中文，预留多语 |

### 3.3 建议目录结构

```text
lib/
  app/                 # 入口、主题、路由
  core/                # 通用：网络、错误、日志、扩展
  data/
    static/            # 本地静态 JSON 加载与解析
    local/             # Hive 仓库(收藏/历史/缓存)
    remote/            # 后端代理客户端(LlmGateway)
  domain/
    models/            # 风格/人物/场景/模板/指导 实体
    recommendation/    # 规则推荐引擎
    repositories/      # 仓库接口
  features/
    home/ style/ person/ scene/ guidance/ favorite/ history/
  l10n/
assets/
  data/                # styles.json scenes.json poses.json ...
  images/              # 模板示意图、轮廓图、构图叠加图
```

### 3.4 本地静态数据

- 全量风格 / 人物类型 / 场景 / 姿势模板配置以 JSON 形式置于 `assets/data/`，随包发布。
- 图片资产置于 `assets/images/`，每个模板对应「示意图 + 轮廓/叠加图」两张静态图（边框、箭头、构图框已画死在图上）。
- 数据结构与校验规则见 [data-model.md](data-model.md)。

## 4. 后端代理（BFF）

### 4.1 定位

一个**最小、无状态**的中间层，唯一存在理由是：保管 LLM 密钥、统一 provider、做限流/缓存/降级。**不存储任何用户数据，不承担业务持久化。**

### 4.2 技术选型

- 运行时：Node.js (TypeScript) + Fastify，或 Python + FastAPI（二选一，按团队栈）。下文以接口契约描述，不绑定语言。
- 部署：单容器即可，可上 Serverless（Cloud Run / 函数计算）以削峰。
- 配置：provider、模型、端点、Key 全部走环境变量，不写死代码。

### 4.3 对外接口（客户端调用）

| 方法 | 路径 | 用途 |
| ---- | ---- | ---- |
| POST | `/v1/style-recommend` | 输入场景/人物/文字描述，返回推荐风格排序 |
| POST | `/v1/guidance-copy` | 输入选定模板上下文，返回个性化指导文案 |
| GET | `/healthz` | 健康检查 |

请求 / 响应的字段与 JSON Schema 见 [llm-spec.md](llm-spec.md)。两个接口都遵循：**入参强校验 → 命中缓存直接返回 → 调用 LLM → 校验输出 Schema → 失败则返回降级标记**。

### 4.4 横切能力

- **鉴权**：客户端携带应用级 API token（防滥用，非用户身份），后端校验。
- **限流**：基于 IP + token 的滑动窗口限流，保护成本。
- **缓存**：以「能力 + 规范化入参」哈希为 key，缓存 LLM 结果（TTL 可配，如 7 天）。同样的风格+场景+人物组合不重复付费。
- **超时与重试**：单次 LLM 调用超时（如 8s），失败按策略切换备用 provider 或返回降级。
- **可观测**：结构化日志（provider、模型、耗时、token、是否命中缓存、是否降级），不记录可识别个人信息。

## 5. LLM Provider 统一抽象（核心）

### 5.1 目标

业务代码（两个能力的 service）只面向一个接口编程，**不知道也不关心底层是 Anthropic 还是 OpenAI 协议**。新增 provider = 新增一个实现类 + 注册到工厂，零改动业务层。

### 5.2 统一接口（语言无关，伪代码）

```ts
// 统一请求：与厂商无关的规范化形态
interface LlmRequest {
  system: string;              // system 指令
  user: string;                // 用户内容(已拼好的 prompt)
  responseSchema?: JsonSchema; // 需要结构化输出时提供
  maxTokens: number;
  temperature: number;
}

// 统一响应
interface LlmResponse {
  json?: unknown;     // 若请求了结构化输出，解析后的对象
  text?: string;      // 纯文本输出
  usage: { inputTokens: number; outputTokens: number };
  provider: string;   // 实际命中的 provider/model，便于观测
}

interface LlmProvider {
  readonly name: string;
  complete(req: LlmRequest): Promise<LlmResponse>;
}
```

### 5.3 工厂与选择策略

```ts
type ProviderName = 'anthropic' | 'openai' | string;

class LlmProviderFactory {
  // 按配置创建/缓存 provider 实例
  static create(name: ProviderName): LlmProvider { /* ... */ }

  // 业务侧拿到的是「带降级链的」provider
  static resolve(): LlmProvider {
    const primary = create(env.LLM_PRIMARY);        // 如 'anthropic'
    const fallbacks = env.LLM_FALLBACKS.split(',')  // 如 ['openai']
                         .map(create);
    return new FailoverProvider(primary, fallbacks); // 主挂了顺序切换
  }
}
```

- `LLM_PRIMARY` / `LLM_FALLBACKS` 由环境变量决定，运维可随时调整主备，无需改代码。
- `FailoverProvider` 也是一个 `LlmProvider`，对上层透明地实现「主→备」降级。
- 若所有 provider 均失败，service 层捕获并返回 `degraded=true`，客户端回退到本地静态文案。

### 5.4 各 provider 实现差异（封装在实现类内部）

| 关注点 | AnthropicImpl | OpenAIImpl |
| ---- | ---- | ---- |
| 端点 | Messages API (`/v1/messages`) | Chat Completions (`/v1/chat/completions`) |
| system 指令 | 顶层 `system` 字段 | `messages[0]` role=`system` |
| 结构化输出 | 工具调用(tool/`input_schema`)或预填充约束 | `response_format: json_schema` / `tools` |
| 模型 id | 由配置注入（如 `claude-sonnet-4-6`） | 由配置注入（如 `gpt-4o-mini` 或兼容端点模型名） |
| 用量字段 | `usage.input_tokens/output_tokens` | `usage.prompt_tokens/completion_tokens` |

> 模型 id 一律走配置，不在文档锁死，避免与实际可用模型脱节。OpenAI 协议实现同样适用于「兼容 OpenAI 协议」的第三方端点（国产模型、自建 vLLM/Ollama），只需改 `baseURL` 与模型名。

### 5.5 为什么不在客户端直接接 LLM

- 客户端无法安全保管 Key（反编译即泄露）。
- provider 切换、限流、缓存、降级集中在后端，客户端零改动。
- 统一观测与成本控制。

## 6. 关键数据流

### 6.1 核心闭环（纯本地，无网络）

```text
用户选风格 → 选人物类型 → 选场景
        → RecommendationEngine 按规则筛选+排序姿势模板(本地)
        → 加载模板静态图与字段文案
        → 指导页渲染图文
```

### 6.2 LLM 增值流（可选，走后端）

```text
[智能推荐风格]  场景+人物(+文字描述) → /v1/style-recommend → 风格排序
[个性化文案]    选定模板上下文       → /v1/guidance-copy   → 润色后的步骤文案
            └── 任一失败 → 使用本地静态文案/默认排序兜底
```

## 7. 降级与容错矩阵

| 故障 | 表现 | 兜底 |
| ---- | ---- | ---- |
| 无网络 | LLM 能力不可用 | 全部核心闭环正常，使用静态文案与默认推荐排序 |
| 后端不可达 / 超时 | 增值能力失败 | 客户端 catch 后回退静态文案，提示「已使用基础指导」 |
| 主 provider 故障 | 后端切备用 provider | 对客户端透明 |
| LLM 输出不合 Schema | 校验失败 | 后端重试一次→仍失败则返回 `degraded`，客户端兜底 |

## 8. 安全与隐私

- 客户端不含任何 LLM Key；仅持应用级访问 token。
- 后端不持久化用户数据；日志脱敏，不记录可识别个人信息。
- 不采集真实照片 / 视频（产品边界本身不涉及）。
- 收藏 / 历史仅存本地设备，提供清除入口（对应 PRD 14.3）。
- 文字描述场景属用户输入，传给 LLM 前做长度与内容基本校验。

## 9. 部署形态

| 组件 | 形态 | 说明 |
| ---- | ---- | ---- |
| 客户端 | App Store / Google Play 包 | 静态数据与图片随包发布 |
| 后端代理 | 单容器 / Serverless | 无状态，水平扩展，按需扩缩 |
| 配置 | 环境变量 | provider、模型、端点、Key、限流阈值、缓存 TTL |
| 缓存 | 进程内 / Redis（可选） | 量小先进程内，增长后切 Redis |

## 10. 第一版明确不做（架构层面）

- 不做账号体系、用户云端数据、跨设备同步。
- 不做管理后台、模板热更新（数据随版本发布）。
- 不做拍照、录像、上传、评分、存储成片的任何链路。
- 不做客户端直连 LLM。
- 不做程序化动态绘制叠加层（第一版叠加层画死在静态图上）。

## 11. 后续可扩展点（不影响第一版结构）

- 新增 LLM provider：仅加实现类并注册工厂。
- 模板热更新：后端增加一个静态数据下发接口，客户端做版本比对。
- 动态可视化：将叠加层坐标数据化，由客户端按锚点绘制（data-model 已为锚点预留扩展位）。
- 视频拍摄指导（PRD 第二阶段）：复用推荐引擎与 LLM 抽象，新增视频维度字段。
