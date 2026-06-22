# 镜界 Lenscape 后端代理 (BFF)

无状态中间层，唯一职责：保管 LLM 密钥、统一 provider、做限流 / 缓存 / 降级。
**不存储任何用户数据。** 设计见 [../docs/architecture.md](../docs/architecture.md) §4–§5 与 [../docs/llm-spec.md](../docs/llm-spec.md)。

## 技术栈

Node ≥ 20 · TypeScript · Fastify · ajv（Schema 校验）· 原生 `fetch` 调 LLM（不绑厂商 SDK）。

## 快速开始

```bash
npm install
cp .env.example .env      # 填入 ANTHROPIC_API_KEY 或 OPENAI_API_KEY
npm run dev               # 开发（自动加载 .env、热重载）
# 或
npm run build && npm start
```

未配置任何 Key 时，接口会优雅降级（`degraded:true`）返回本地兜底结果，便于联调。

## 脚本

| 命令 | 说明 |
| ---- | ---- |
| `npm run dev` | 开发模式（tsx + watch，自动读 .env） |
| `npm run build` | 编译到 `dist/` |
| `npm start` | 运行编译产物 |
| `npm run typecheck` | 仅类型检查 |
| `npm test` | vitest 单元 + 集成测试 |

## 接口

| 方法 | 路径 | 说明 |
| ---- | ---- | ---- |
| GET | `/healthz` | 健康检查（豁免鉴权） |
| POST | `/v1/style-recommend` | 风格推荐（见 llm-spec §3） |
| POST | `/v1/guidance-copy` | 指导文案生成（见 llm-spec §4） |

除 `/healthz` 外，请求需带 `Authorization: Bearer <APP_TOKEN>`（`APP_TOKENS` 为空时豁免，仅限本地）。

## 多 provider

`LLM_PRIMARY` 与 `LLM_FALLBACKS`（逗号分隔）决定主备链；任一 provider 失败按序切换，全部失败则接口降级。
新增 provider：实现 `LlmProvider` 接口（`src/llm/providers/`）并在 `src/llm/factory.ts` 注册，业务层零改动。

## 目录

```text
src/
  config.ts            # 环境变量
  app.ts               # Fastify 组装（鉴权/限流/路由）
  index.ts             # 入口
  lib/                 # cache（含缓存键）、schema（ajv 校验）
  llm/                 # provider 抽象：types/factory/failover/providers
  capabilities/        # 能力：runner（通用流程）+ styleRecommend + guidanceCopy
  routes/              # HTTP 路由
test/                  # 单元 + 集成测试
```
