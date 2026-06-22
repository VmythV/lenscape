# 镜界 Lenscape 实现 TODOLIST

> 配套文档：[产品需求](prd.md) · [技术架构](architecture.md) · [数据模型与推荐规则](data-model.md) · [LLM 接口契约](llm-spec.md)
>
> 共 16 项任务，分四条可并行轨道 + 收尾。`←` 表示依赖（被依赖项完成后才能开始）。

## 关键路径

`#5 → #6 → #7 → #9 → #18 → #20`（客户端核心闭环）。

后端轨（#10/#11）与内容轨（#8）从第一天即可与客户端骨架并行。**内容轨 #8 是真正的人力瓶颈，优先安排。**

## 客户端轨（Flutter）

- [ ] **#5 初始化 Flutter 工程骨架**
  创建工程，按 architecture §3.3 建目录(app/core/data/domain/features/l10n)，接入 riverpod、go_router、dio、hive、freezed+json_serializable、flutter_intl；配置主题、路由骨架、中文 i18n。
- [ ] **#6 定义领域模型与枚举** ← #5
  用 freezed 定义 Style/Scene/PersonType/PoseTemplate/Favorite/HistoryEntry 及全部受控枚举(data-model §1/§2)，含 json 序列化与不可变约束。
- [ ] **#7 本地静态数据加载层 + 构建期校验脚本** ← #6
  从 assets/data/*.json 加载解析为模型；校验脚本(枚举合法、外键存在、图片资产存在、*_instruction 非空且不含黑名单占位词、每风格≥3 个 reviewed 模板)，接入 CI。
- [ ] **#9 实现推荐引擎(规则) + 单测** ← #7
  RecommendationEngine：能力A 场景→风格打分排序(§3.1)；能力B 姿势模板硬过滤+偏好打分+逐级兜底(§3.2，返回 relaxedScene/relaxedPerson)。覆盖空结果兜底、权重、边界单测。
- [ ] **#15 本地持久化(收藏/历史)仓库** ← #6
  Hive 实现 FavoriteRepository 与 HistoryRepository：收藏增删查、历史去重倒序+上限滚动淘汰、清除入口(隐私)。

## 后端轨（BFF，可与客户端并行）

- [ ] **#10 搭建后端代理脚手架**
  无状态 BFF(Fastify/TS 或 FastAPI)：环境变量配置、/healthz、应用级 token 鉴权、滑动窗口限流、缓存层(进程内，预留 Redis)、结构化日志(脱敏)、统一错误与 Schema 校验中间件。
- [ ] **#11 LLM Provider 统一抽象 + 多 provider** ← #10
  按 architecture §5 实现 LlmProvider 接口、LlmProviderFactory、FailoverProvider(主备降级)；AnthropicImpl(Messages API + tool 结构化输出)与 OpenAIImpl(Chat Completions + json_schema，兼容自建端点)；输出统一再做 JSON Schema 校验。
- [ ] **#12 实现 /v1/style-recommend** ← #11
  llm-spec §3：入参校验、Prompt 组装、候选越界过滤、输出 Schema 校验、重试与 degraded 兜底(candidate_styles 排序)、缓存键(含 user_note)。
- [ ] **#13 实现 /v1/guidance-copy** ← #11
  llm-spec §4：入参校验、Prompt 组装(不改硬参数)、steps/tips 长度与条数校验、重试与 degraded 兜底(模板 *_instruction 拼接)、缓存。

## 内容轨（人力瓶颈，尽早启动）

- [ ] **#8 生产首版静态内容资产**（无代码依赖，第一天开工）
  6 风格/8 场景/5 人物类型配置 JSON，每风格 4 个姿势模板(共约 24 套)；AI 文生图+人工审核出示意图与含叠加层(边框/箭头/构图框)的轮廓图；文案 LLM 起草后人工审核，置 is_reviewed=true。

## 页面轨（依赖前序就绪）

- [ ] **#14 客户端 LlmGateway + 降级回退** ← #12 #13
  dio 封装调用后端两接口，超时/失败/degraded 回退本地规则排序与模板静态文案；领域层统一暴露。
- [ ] **#16 页面：首页 + 风格选择页** ← #7 #9
  首页(产品名、拍摄指导入口、热门风格、常用场景、收藏/最近浏览入口，不含拍照/上传)；风格选择页(卡片列表、示例图、说明、适合场景/人物、进入下一步)。PRD 11.1/11.2。
- [ ] **#17 页面：人物类型页 + 场景页** ← #9 #14
  人物类型选择页(5 类)；场景选择页(手动选场景、可选文字描述、调用风格推荐并展示排序+理由、继续按钮)。PRD 11.3/11.4。
- [ ] **#18 页面：拍摄指导页**（核心）← #9 #14 #15
  当前风格/人物/场景、示意图+轮廓叠加图、图文步骤(LlmGateway 生成、degraded 时提示并用静态文案)、注意事项、切换姿势模板、收藏、放宽条件提示、返回。PRD 11.5。
- [ ] **#19 页面：收藏页 + 历史浏览页** ← #15
  收藏列表(进入对应模板指导)、最近浏览列表(去重倒序)、清除入口。PRD P1。

## 收尾

- [ ] **#20 联调、端到端测试与 CI** ← #16 #17 #18 #19
  核心闭环 e2e(选风格→人物→场景→指导)、降级路径(断网/后端不可达/Schema 不过)、provider 主备切换验证、性能校验(PRD 14.2)；CI 接入数据校验脚本与单测。

## 建议起步

从 **#5（Flutter 骨架）** 与 **#10（后端脚手架）** 同步起步，同时让 **#8（内容生产）** 开工。
