# 镜界 Lenscape LLM 接口契约与 Prompt

> 配套文档：[技术架构](architecture.md) · [数据模型与推荐规则](data-model.md) · [产品需求](prd.md)
>
> 本文档定义后端代理对外的两个 LLM 能力接口、provider 无关的调用约定、结构化输出 Schema 与 Prompt 模板。**所有 LLM 调用经统一 provider 抽象（见 architecture §5），业务层与 Prompt 不绑定任何厂商。**

## 1. 总则

| 约定 | 内容 |
| ---- | ---- |
| 角色 | LLM 仅做「风格推荐排序」与「指导文案润色生成」两件事，不做评分/分析/拍后建议 |
| 输入边界 | 入参均为结构化字段（风格/人物/场景 code + 可选文字描述），不含图片、不含用户照片 |
| 输出约束 | 一律要求**结构化 JSON 输出**，并按 Schema 强校验；不接受自由散文 |
| 兜底 | 任一能力失败/超时/校验不过 → 返回 `degraded=true`，客户端回退本地静态数据 |
| 缓存 | 以 `能力 + 规范化入参` 的哈希为 key 缓存（见 §6） |
| 语言 | 输出中文，面向无摄影经验的普通用户 |
| 反废话 | 严禁输出「自然一点」「找好角度」等不可执行表述（对应 PRD 19.2） |

## 2. provider 无关的结构化输出

统一接口接受可选 `responseSchema`，各 provider 实现内部用各自机制保证 JSON：

| provider | 结构化输出机制 |
| ---- | ---- |
| Anthropic（Messages API） | 定义一个工具，`input_schema` = 目标 Schema，强制 `tool_choice` 调用该工具，从 `tool_use.input` 取结果 |
| OpenAI 协议（Chat Completions） | `response_format: { type: "json_schema", json_schema: { schema, strict: true } }`；兼容端点不支持时退化为 `json_object` + 提示约束 |

后端拿到结果后**统一再做一次 JSON Schema 校验**（不信任 provider 自带保证），不过则按 §5 处理。

模型与端点由配置注入（如 Anthropic `claude-sonnet-4-6`、OpenAI 协议 `gpt-4o-mini` 或自建端点模型名），文档不锁死。

## 3. 能力一：风格推荐 `/v1/style-recommend`

### 3.1 用途

用户在场景页希望系统推荐风格时调用。后端先用本地无关的逻辑无法获得数据，故由客户端把**本地规则算出的候选风格**一并传入，LLM 负责结合（可选的）用户文字描述做**重排序与简短理由**，而非凭空捏造风格。

### 3.2 请求

```json
{
  "scene_id": "cafe",
  "person_type": "female",
  "user_note": "想要安静、文艺一点的氛围",      // 可选，用户文字描述场景/诉求
  "candidate_styles": [                        // 客户端用 data-model §3.1 规则算出的候选
    { "style_id": "korean",   "style_name": "韩系风格",  "base_score": 6 },
    { "style_id": "japanese", "style_name": "日系清新",  "base_score": 5 },
    { "style_id": "street",   "style_name": "街拍风格",  "base_score": 2 }
  ]
}
```

| 字段 | 必填 | 说明 |
| ---- | ---- | ---- |
| `scene_id` | 是 | 场景 code |
| `person_type` | 是 | 人物类型 code |
| `user_note` | 否 | 用户文字描述，长度上限 200 字，做基本内容校验 |
| `candidate_styles` | 是 | 仅在候选集合内重排，**禁止 LLM 引入候选外风格** |

### 3.3 输出 Schema

```json
{
  "type": "object",
  "additionalProperties": false,
  "required": ["recommendations"],
  "properties": {
    "recommendations": {
      "type": "array",
      "minItems": 1,
      "items": {
        "type": "object",
        "additionalProperties": false,
        "required": ["style_id", "reason"],
        "properties": {
          "style_id": { "type": "string" },
          "reason":   { "type": "string", "maxLength": 40 }
        }
      }
    }
  }
}
```

### 3.4 响应（后端封装给客户端）

```json
{
  "degraded": false,
  "recommendations": [
    { "style_id": "japanese", "reason": "咖啡店光线柔和，日系清新最能拍出安静文艺感" },
    { "style_id": "korean",   "reason": "适合半身近景，突出氛围与妆容质感" }
  ]
}
```

- 后端校验 `style_id` 必须 ∈ `candidate_styles`，剔除越界项。
- `degraded=true` 时 `recommendations` 直接用 `candidate_styles` 的 `base_score` 排序。

### 3.5 Prompt

**System：**

```text
你是镜界 App 的拍摄风格推荐助手。你的唯一任务：在给定的候选风格中，结合拍摄场景、人物类型和用户描述，做重新排序并给出一句简短理由。

严格规则：
1. 只能从候选风格里选，禁止引入候选之外的任何风格。
2. 按推荐优先级从高到低排序，最相关的排第一。
3. 每条理由不超过 40 字，必须具体说明"为什么这个场景/人物适合该风格"，不要写空话。
4. 只输出结构化结果，不要输出多余文字。
```

**User（模板，`{{}}` 为变量）：**

```text
场景：{{scene_name}}（{{scene_description}}）
人物类型：{{person_name}}
用户描述：{{user_note 或 "无"}}

候选风格：
{{#each candidate_styles}}
- {{style_id}} {{style_name}}
{{/each}}

请对以上候选风格重新排序并给出理由。
```

## 4. 能力二：指导文案生成 `/v1/guidance-copy`

### 4.1 用途

用户进入指导页、对某个已选定的姿势模板，希望获得更贴合当前场景的个性化文字步骤。LLM **基于模板已有的结构化字段润色改写**，不改变机位/构图等硬参数，只让文案更具体、连贯、口语化。

### 4.2 请求

```json
{
  "style":  { "style_id": "korean", "style_name": "韩系风格" },
  "person": { "person_type": "female", "person_name": "女生" },
  "scene":  {
    "scene_id": "cafe", "scene_name": "咖啡店",
    "foreground_hints": ["桌面", "咖啡杯"],
    "background_hints": ["窗户"],
    "keep_background": true
  },
  "pose": {
    "pose_id": "cafe_sit_001",
    "pose_name": "韩系咖啡店坐姿照",
    "body_instruction": "坐在靠窗位置，身体微微侧向拍摄方向。",
    "hand_instruction": "一只手放桌面，另一只手可拿咖啡杯。",
    "face_instruction": "脸部朝向窗外。",
    "eye_instruction": "眼神看向窗外，不直视镜头。",
    "position_instruction": "人物在画面中间偏右。",
    "camera_position_instruction": "拍摄者站在人物斜前方 45 度。",
    "camera_height": "chest", "camera_angle": "top_down",
    "camera_direction": "front_45", "camera_distance": "near",
    "subject_position": "right_third", "subject_ratio": "subject_first",
    "composition_instruction": "竖屏构图，保留窗户和桌面。",
    "tips": ["减少桌面杂物"]
  }
}
```

### 4.3 输出 Schema

```json
{
  "type": "object",
  "additionalProperties": false,
  "required": ["steps", "tips"],
  "properties": {
    "steps": {
      "type": "array", "minItems": 4, "maxItems": 8,
      "items": { "type": "string", "minLength": 6, "maxLength": 60 }
    },
    "tips": {
      "type": "array", "maxItems": 4,
      "items": { "type": "string", "maxLength": 40 }
    }
  }
}
```

### 4.4 响应（后端封装）

```json
{
  "degraded": false,
  "steps": [
    "坐在靠窗的位置，身体微微侧向拍摄者，不要正对镜头。",
    "一只手自然放在桌面，另一只手可以端起咖啡杯。",
    "眼神看向窗外，表情放松，不用直视镜头。",
    "拍摄者站在你斜前方约 45 度的位置。",
    "手机略高于眼睛，从上往下轻微俯拍。",
    "用竖屏构图，把你放在画面中间偏右，保留窗户和桌面。"
  ],
  "tips": ["尽量收走桌面多余杂物", "靠窗找均匀光线"]
}
```

- `degraded=true` 时，客户端直接用模板的 `*_instruction` 字段拼成步骤展示。

### 4.5 Prompt

**System：**

```text
你是镜界 App 的拍摄指导文案助手，面向完全没有摄影经验的普通用户。

任务：根据给定的姿势模板字段、场景和人物类型，输出一套清晰、具体、可直接照做的拍摄步骤。

严格规则：
1. 不得改变模板给定的机位、角度、构图等硬参数，只做表达上的改写与串联。
2. 每一步都必须是可执行的具体动作或位置，禁止出现"自然一点""找好角度""注意构图"等空泛说法。
3. 步骤覆盖：人物怎么坐/站、手怎么放、脸和眼神朝哪、拍摄者站哪、设备多高什么角度、横竖屏与人物位置、背景如何取舍。
4. 用第二人称、口语化中文，每步不超过 60 字。
5. tips 给 0~4 条简短注意事项。
6. 只输出结构化结果。
```

**User（模板）：**

```text
风格：{{style_name}}
人物类型：{{person_name}}
场景：{{scene_name}}（建议保留背景：{{keep_background}}；可用前景：{{foreground_hints}}；可用背景：{{background_hints}}）

姿势模板「{{pose_name}}」的要点：
- 身体：{{body_instruction}}
- 手部：{{hand_instruction}}
- 面部：{{face_instruction}}
- 眼神：{{eye_instruction}}
- 站位：{{position_instruction}}
- 拍摄者机位：{{camera_position_instruction}}
- 设备高度/角度：{{camera_height}} / {{camera_angle}}
- 拍摄方向/距离：{{camera_direction}} / {{camera_distance}}
- 人物位置/景物比例：{{subject_position}} / {{subject_ratio}}
- 构图：{{composition_instruction}}
- 已有提示：{{tips}}

请据此生成最终的拍摄步骤与注意事项。
```

## 5. 校验、重试与降级

后端对每个能力统一处理流程：

```text
1. 入参 Schema 校验失败            → 400，不调 LLM
2. 命中缓存                        → 直接返回（degraded=false）
3. 调 LLM（resolve() 带主备 provider 的 FailoverProvider）
4. 输出 JSON Schema 校验：
     通过                          → 写缓存，返回
     不通过 → 同 provider 重试 1 次
              仍不通过             → 返回 degraded=true + 兜底数据
5. 全部 provider 调用失败/超时      → 返回 degraded=true + 兜底数据
```

- **业务级越界校验**：风格推荐的 `style_id` 必须在候选内；指导文案的步骤数与长度符合 Schema。
- **兜底数据**：能力一用 `candidate_styles` 排序；能力二用模板 `*_instruction` 拼接。客户端据 `degraded` 决定是否提示「已使用基础指导」。

## 6. 缓存键

```text
cache_key = sha256( capability + "|" + canonical_json(normalized_input) )
```

- `normalized_input`：去除可选空字段、对数组排序、去掉与输出无关的展示字段（如 `style_name`），保证等价输入命中同一缓存。
- 能力一：`user_note` 参与 key（不同描述应给不同推荐）。
- TTL 可配（建议 7 天）。模板/文案内容随版本更新时，可在 key 中拼入内容版本号 `content_version` 做整体失效。

## 7. 调用参数建议（按能力，均可配置）

| 能力 | temperature | max_tokens | 说明 |
| ---- | ---- | ---- | ---- |
| 风格推荐 | 0.3 | 512 | 偏确定性，避免发散 |
| 指导文案 | 0.5 | 800 | 略放松以获得自然口语，但受 Schema 约束 |

## 8. 成本与观测

- 两个能力均短输入短输出，配合缓存，单用户单次会话调用次数低。
- 后端按 provider/model 记录 token 用量与命中率（脱敏，不记录可识别个人信息）。
- 模型与 provider 由配置切换，可随成本/质量变化随时调整，无需改业务代码或 Prompt。
