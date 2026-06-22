# 镜界 Lenscape 数据模型与推荐规则

> 配套文档：[产品需求](prd.md) · [技术架构](architecture.md) · [LLM 接口契约](llm-spec.md)
>
> 本文档定义第一版本地静态数据的实体结构、受控词表（枚举）和规则推荐算法。所有数据以 JSON 打包进 Flutter 客户端的 `assets/data/`。

## 1. 受控词表（枚举）

所有跨实体引用的字段都使用稳定的英文 `code`，中文名仅用于展示。**code 一经发布不可更改**（破坏存量数据）。

### 1.1 风格 style_id（第一版 6 个）

| code | 中文名 |
| ---- | ---- |
| `korean` | 韩系风格 |
| `japanese` | 日系清新 |
| `hongkong` | 港风复古 |
| `street` | 街拍风格 |
| `travel` | 旅行大片 |
| `couple` | 情侣写真 |

> PRD 列出 12 个候选风格；按已确认范围第一版先实现以上 6 个，其余（职场形象照、证件照、探店氛围感、穿搭展示、生活随拍、高级感大片）作为 code 预留，后续补模板即可上线。

### 1.2 人物类型 person_type

| code | 中文名 | 推荐方向 |
| ---- | ---- | ---- |
| `male` | 男生 | 自然、松弛、力量感、街拍感、利落感 |
| `female` | 女生 | 显身材、氛围感、柔和感、精致感 |
| `unlimited` | 不限性别 | 走路、回头、侧身、坐姿、看远方等通用 |
| `couple` | 情侣 | 并肩、牵手、对视、错位站位、互动 |
| `group` | 多人 | 队形、层次、前后错位、高低关系 |

### 1.3 场景 scene_id（第一版 8 个）

| code | 中文名 |
| ---- | ---- |
| `indoor` | 室内 |
| `outdoor` | 户外 |
| `cafe` | 咖啡店 |
| `street` | 街道 |
| `scenic` | 景区 |
| `seaside` | 海边 |
| `mall` | 商场 |
| `park` | 公园 |

> PRD 列 12 个场景，第一版先做以上 8 个常见场景，其余（办公室、车内、餐厅、建筑外墙）预留 code。

### 1.4 拍摄参数枚举

| 维度 | 字段 | 取值 code |
| ---- | ---- | ---- |
| 画幅 | `orientation` | `vertical` 竖屏 / `horizontal` 横屏 |
| 取景 | `framing` | `full_body` 全身 / `half_body` 半身 / `close_up` 近景 |
| 设备高度 | `camera_height` | `eye_level` 眼平 / `chest` 胸口 / `waist` 腰部 / `low` 低位 / `high` 高位 |
| 设备角度 | `camera_angle` | `level` 平视 / `top_down` 俯拍 / `bottom_up` 仰拍 |
| 拍摄方向 | `camera_direction` | `front` 正面 / `front_45` 斜前方 / `side` 侧面 / `back` 背后 |
| 拍摄距离 | `camera_distance` | `near` 近景 / `mid` 中景 / `far` 远景 |
| 人物位置 | `subject_position` | `center` 居中 / `left_third` 左三分之一 / `right_third` 右三分之一 |
| 景物比例 | `subject_ratio` | `subject_first` 人物为主 / `balanced` 均衡 / `scene_first` 景物为主 |

## 2. 实体结构

### 2.1 风格 Style（`assets/data/styles.json`）

```json
{
  "style_id": "street",
  "style_name": "街拍风格",
  "style_description": "适合街道、建筑外墙、城市道路等场景，强调自然、松弛、氛围感。",
  "sample_images": ["images/styles/street_01.webp"],
  "suitable_scenes": ["street", "mall", "scenic"],
  "suitable_person_types": ["male", "female", "unlimited", "couple"],
  "default_orientation": "vertical",
  "default_framing": "full_body",
  "composition_rules": ["right_third", "balanced"],
  "camera_rules": ["chest", "bottom_up"],
  "sort_weight": 80
}
```

| 字段 | 类型 | 说明 |
| ---- | ---- | ---- |
| `style_id` | string(enum) | 唯一 code |
| `style_name` | string | 展示名 |
| `style_description` | string | 风格说明 |
| `sample_images` | string[] | 示例图资产路径 |
| `suitable_scenes` | scene_id[] | 适合场景，用于推荐打分 |
| `suitable_person_types` | person_type[] | 适合人物类型 |
| `default_orientation` / `default_framing` | enum | 默认画幅/取景 |
| `composition_rules` | enum[] | 推荐构图（subject_position / subject_ratio 取值） |
| `camera_rules` | enum[] | 推荐机位（camera_height / camera_angle 取值） |
| `sort_weight` | int(0-100) | 同分时的展示优先级 |

### 2.2 场景 Scene（`assets/data/scenes.json`）

```json
{
  "scene_id": "cafe",
  "scene_name": "咖啡店",
  "scene_description": "适合探店氛围感、韩系、日系清新等风格。",
  "example_images": ["images/scenes/cafe_01.webp"],
  "suitable_styles": ["korean", "japanese"],
  "unsuitable_styles": ["travel"],
  "recommended_orientation": "vertical",
  "recommended_framing": "half_body",
  "recommended_camera": ["front_45", "top_down", "chest"],
  "foreground_hints": ["桌面", "咖啡杯"],
  "background_hints": ["窗户", "吧台"],
  "keep_background": true
}
```

| 字段 | 类型 | 说明 |
| ---- | ---- | ---- |
| `suitable_styles` | style_id[] | 该场景适合的风格，**风格推荐打分主依据** |
| `unsuitable_styles` | style_id[] | 明显不适合的风格，打分时扣分 |
| `recommended_*` | enum | 场景级机位/构图建议 |
| `foreground_hints` / `background_hints` | string[] | 可作前景/背景的元素，喂给 LLM 文案 |
| `keep_background` | bool | 是否建议保留背景 |

### 2.3 人物类型 PersonType（`assets/data/person_types.json`）

```json
{
  "person_type": "couple",
  "person_name": "情侣",
  "direction": "并肩、牵手、对视、错位站位、互动动作",
  "min_people": 2,
  "max_people": 2
}
```

### 2.4 姿势模板 PoseTemplate（`assets/data/poses.json`，核心实体）

```json
{
  "pose_id": "street_walking_001",
  "pose_name": "街边自然走路照",
  "style_ids": ["street", "travel"],
  "person_types": ["male", "female", "unlimited"],
  "scene_types": ["street", "scenic"],

  "illustration_image": "images/poses/street_walking_001.webp",
  "pose_outline_image": "images/poses/street_walking_001_outline.webp",

  "supports_orientation": ["vertical"],
  "supports_framing": ["full_body", "half_body"],

  "body_instruction": "身体轻微侧向拍摄方向，自然向前走。",
  "hand_instruction": "一只手插兜，另一只手自然摆动。",
  "face_instruction": "脸部自然朝向前方或微微侧向拍摄方向。",
  "eye_instruction": "眼神看向远处，不必直视拍摄方向。",
  "position_instruction": "人物位于画面右侧三分之一位置。",
  "camera_position_instruction": "拍摄者站在人物斜前方 3 到 5 米。",
  "camera_height": "chest",
  "camera_angle": "bottom_up",
  "camera_direction": "front_45",
  "camera_distance": "mid",
  "subject_position": "right_third",
  "subject_ratio": "balanced",
  "composition_instruction": "使用竖屏构图，保留街道和建筑背景。",
  "tips": ["避免背景杂乱", "人物不要贴近画面边缘"],

  "quality_score": 90,
  "is_reviewed": true
}
```

| 字段组 | 字段 | 说明 |
| ---- | ---- | ---- |
| 关联 | `style_ids` / `person_types` / `scene_types` | 多对多关联，推荐打分依据 |
| 资产 | `illustration_image` / `pose_outline_image` | 示意图 + 含叠加层的轮廓图（两张静态图，必填，对应 PRD 验收） |
| 适配 | `supports_orientation` / `supports_framing` | 支持的画幅/取景，用于可选偏好过滤 |
| 文案 | `*_instruction` | 身体/手部/面部/眼神/站位/机位/构图 文字步骤（静态兜底，LLM 在此基础上润色） |
| 参数 | `camera_*` / `subject_*` | 结构化机位与构图参数（枚举），供 UI 与 LLM 使用 |
| 提示 | `tips` | 注意事项 |
| 治理 | `quality_score`(0-100) / `is_reviewed` | 人工审核质量分，未审核(`false`)不进推荐 |

**校验约束**（构建期脚本检查，对应 PRD 风险 19.1/19.3）：

1. 每个 `style_id` 至少关联 3 个 `is_reviewed=true` 的模板（PRD 验收：每风格 3–5 个；目标 4 个）。
2. `illustration_image`、`pose_outline_image` 必须存在且文件可解析。
3. 所有 `*_instruction` 非空，且不得包含「自然一点」「找好角度」等占位词（黑名单校验，对应 PRD 19.2）。
4. 所有枚举字段取值必须在受控词表内。
5. 关联的 style/scene/person code 必须在各自表中存在（外键校验）。

### 2.5 收藏 Favorite（本地 Hive，非打包）

```json
{ "pose_id": "street_walking_001", "created_at": 1750560000000 }
```

### 2.6 历史 HistoryEntry（本地 Hive，非打包）

```json
{
  "pose_id": "street_walking_001",
  "context": { "style_id": "street", "person_type": "male", "scene_id": "street" },
  "viewed_at": 1750560000000
}
```

> 历史按 `viewed_at` 倒序，去重保留最近一次，最多保留 N 条（如 50），超出滚动淘汰。

## 3. 推荐规则

推荐分两个独立能力：**(A) 场景 → 风格推荐**（本地规则兜底 + LLM 增强）与 **(B) 风格/人物/场景 → 姿势模板推荐**（纯本地规则，第一版不接 LLM）。

### 3.1 能力 A：场景 → 风格推荐（本地规则）

当用户在场景页希望系统推荐风格时，本地先算一个排序，作为 LLM 不可用时的兜底，也作为 LLM 的输入参考。

对每个 `style`，给定 `scene` 与 `person_type`，打分：

```text
score(style) =
    W_scene_suit   * (scene.suitable_styles 含 style ? 1 : 0)
  - W_scene_unsuit * (scene.unsuitable_styles 含 style ? 1 : 0)
  + W_style_scene  * (style.suitable_scenes 含 scene ? 1 : 0)
  + W_person       * (style.suitable_person_types 含 person_type ? 1 : 0)
  + style.sort_weight / 100        // 0~1 的平滑项，仅用于同分排序

权重（可调）：
  W_scene_suit   = 3
  W_scene_unsuit = 4   // 不适合的惩罚更重，避免推荐违和组合
  W_style_scene  = 2
  W_person       = 1
```

- 按 `score` 倒序，过滤掉 `score <= 0` 的风格。
- 全部被过滤时，回退展示全部第一版风格（按 `sort_weight`）。
- 该排序结果可直接展示，也可作为 `/v1/style-recommend` 的候选/参考传给 LLM（详见 llm-spec）。

### 3.2 能力 B：姿势模板推荐（本地规则，核心）

输入：`style_id`（必填）、`person_type`（必填）、`scene_id`（必填）、可选 `orientation`、可选 `framing`。

**第一步 硬过滤**（必须全部满足，否则排除）：

```text
template.is_reviewed == true
AND style_id   ∈ template.style_ids
AND person_type ∈ template.person_types
AND scene_id   ∈ template.scene_types
```

**第二步 偏好打分**（在过滤后的集合内排序）：

```text
score(template) =
    template.quality_score                       // 主导项 0~100
  + (orientation 提供且 ∈ supports_orientation ? 10 : 0)
  + (framing     提供且 ∈ supports_framing     ? 10 : 0)
```

- 按 `score` 倒序返回。第一版每个有效组合期望返回 3–5 个模板供用户切换（PRD 10.4 验收）。

**第三步 兜底（关键，避免空结果）**：硬过滤结果为空时，按以下顺序逐级放宽，并向用户标注「已为你放宽了 X 条件」：

```text
1) 放宽 scene_id  → 仅按 style_id + person_type 过滤
2) 再放宽 person_type → 仅按 style_id 过滤（person_type=unlimited 优先）
3) 仍为空 → 返回该 style_id 下 quality_score 最高的若干模板
4) 极端情况(风格无任何模板) → 返回全库 quality_score Top N
```

> 兜底保证「任何选择组合都能看到指导」，不出现空白页。每次放宽都通过返回字段告知 UI，便于提示用户。

### 3.3 推荐引擎接口（客户端领域层）

```dart
abstract class RecommendationEngine {
  /// 能力 A：场景→风格排序（本地兜底）
  List<StyleScore> recommendStyles({
    required String sceneId,
    required String personType,
  });

  /// 能力 B：姿势模板推荐（核心）
  PoseRecommendation recommendPoses({
    required String styleId,
    required String personType,
    required String sceneId,
    String? orientation,
    String? framing,
  });
}

class PoseRecommendation {
  final List<PoseTemplate> templates;
  final bool relaxedScene;      // 是否放宽了场景
  final bool relaxedPerson;     // 是否放宽了人物类型
}
```

## 4. 数据治理与生产流程

1. **唯一来源**：所有 code 以本文件受控词表为准；新增风格/场景/枚举先在此登记。
2. **构建期校验**：CI 跑一个校验脚本（§2.4 约束 + 外键 + 图片存在性），不过不让合并。
3. **内容生产**：模板文案可由 LLM 批量起草 → 人工审核 → 落入 JSON 并置 `is_reviewed=true`；图片走 AI 文生图 + 人工审核（见 architecture §1）。
4. **版本化**：JSON 与图片随 APP 版本发布；第一版不做热更新。

## 5. 与 PRD 数据结构示例的差异说明

PRD §12 的示例为最小演示，本文档在其基础上补全了：人物类型表、收藏/历史模型、`is_reviewed`/`quality_score` 治理字段、结构化机位/构图枚举字段、`supports_*` 适配字段、场景的 `unsuitable_styles` 与前后景提示。这些字段是推荐算法与 LLM 文案生成的必要输入。
