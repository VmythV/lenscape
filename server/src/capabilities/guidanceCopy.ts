import { compile } from "../lib/schema.js";
import type { CapabilitySpec } from "./runner.js";

/** 请求体（见 docs/llm-spec.md §4.2） */
export interface GuidanceCopyInput {
  style: { style_id: string; style_name: string };
  person: { person_type: string; person_name: string };
  scene: {
    scene_id: string;
    scene_name: string;
    foreground_hints?: string[];
    background_hints?: string[];
    keep_background?: boolean;
  };
  pose: {
    pose_id: string;
    pose_name: string;
    body_instruction: string;
    hand_instruction: string;
    face_instruction: string;
    eye_instruction: string;
    position_instruction: string;
    camera_position_instruction: string;
    camera_height: string;
    camera_angle: string;
    camera_direction: string;
    camera_distance: string;
    subject_position: string;
    subject_ratio: string;
    composition_instruction: string;
    tips?: string[];
  };
}

export interface GuidanceCopyOutput {
  steps: string[];
  tips: string[];
}

export const inputSchema = {
  type: "object",
  additionalProperties: false,
  required: ["style", "person", "scene", "pose"],
  properties: {
    style: {
      type: "object",
      additionalProperties: false,
      required: ["style_id", "style_name"],
      properties: {
        style_id: { type: "string", minLength: 1 },
        style_name: { type: "string", minLength: 1 },
      },
    },
    person: {
      type: "object",
      additionalProperties: false,
      required: ["person_type", "person_name"],
      properties: {
        person_type: { type: "string", minLength: 1 },
        person_name: { type: "string", minLength: 1 },
      },
    },
    scene: {
      type: "object",
      additionalProperties: false,
      required: ["scene_id", "scene_name"],
      properties: {
        scene_id: { type: "string", minLength: 1 },
        scene_name: { type: "string", minLength: 1 },
        foreground_hints: { type: "array", items: { type: "string" } },
        background_hints: { type: "array", items: { type: "string" } },
        keep_background: { type: "boolean" },
      },
    },
    pose: {
      type: "object",
      required: [
        "pose_id",
        "pose_name",
        "body_instruction",
        "hand_instruction",
        "face_instruction",
        "eye_instruction",
        "position_instruction",
        "camera_position_instruction",
        "composition_instruction",
      ],
      properties: {
        pose_id: { type: "string", minLength: 1 },
        pose_name: { type: "string", minLength: 1 },
      },
    },
  },
} as const;

const outputSchema = {
  type: "object",
  additionalProperties: false,
  required: ["steps", "tips"],
  properties: {
    steps: {
      type: "array",
      minItems: 4,
      maxItems: 8,
      items: { type: "string", minLength: 6, maxLength: 60 },
    },
    tips: {
      type: "array",
      maxItems: 4,
      items: { type: "string", maxLength: 40 },
    },
  },
} as const;

export const validateInput = compile<GuidanceCopyInput>(inputSchema);
const validateOutput = compile<GuidanceCopyOutput>(outputSchema);

export const guidanceCopySpec: CapabilitySpec<GuidanceCopyInput, GuidanceCopyOutput> = {
  name: "guidance-copy",
  schemaName: "guidance_copy",
  responseSchema: outputSchema as unknown as Record<string, unknown>,
  maxTokens: 800,
  temperature: 0.5,

  buildPrompt(input) {
    const { style, person, scene, pose } = input;
    const system = [
      "你是镜界 App 的拍摄指导文案助手，面向完全没有摄影经验的普通用户。",
      "",
      "任务：根据给定的姿势模板字段、场景和人物类型，输出一套清晰、具体、可直接照做的拍摄步骤。",
      "",
      "严格规则：",
      "1. 不得改变模板给定的机位、角度、构图等硬参数，只做表达上的改写与串联。",
      "2. 每一步都必须是可执行的具体动作或位置，禁止出现“自然一点”“找好角度”“注意构图”等空泛说法。",
      "3. 步骤覆盖：人物怎么坐/站、手怎么放、脸和眼神朝哪、拍摄者站哪、设备多高什么角度、横竖屏与人物位置、背景如何取舍。",
      "4. 用第二人称、口语化中文，每步不超过 60 字。",
      "5. tips 给 0~4 条简短注意事项。",
      "6. 只输出结构化结果。",
    ].join("\n");

    const user = [
      `风格：${style.style_name}`,
      `人物类型：${person.person_name}`,
      `场景：${scene.scene_name}（建议保留背景：${scene.keep_background ?? "未指定"}；可用前景：${(scene.foreground_hints ?? []).join("、") || "无"}；可用背景：${(scene.background_hints ?? []).join("、") || "无"}）`,
      "",
      `姿势模板「${pose.pose_name}」的要点：`,
      `- 身体：${pose.body_instruction}`,
      `- 手部：${pose.hand_instruction}`,
      `- 面部：${pose.face_instruction}`,
      `- 眼神：${pose.eye_instruction}`,
      `- 站位：${pose.position_instruction}`,
      `- 拍摄者机位：${pose.camera_position_instruction}`,
      `- 设备高度/角度：${pose.camera_height} / ${pose.camera_angle}`,
      `- 拍摄方向/距离：${pose.camera_direction} / ${pose.camera_distance}`,
      `- 人物位置/景物比例：${pose.subject_position} / ${pose.subject_ratio}`,
      `- 构图：${pose.composition_instruction}`,
      `- 已有提示：${(pose.tips ?? []).join("、") || "无"}`,
      "",
      "请据此生成最终的拍摄步骤与注意事项。",
    ].join("\n");

    return { system, user };
  },

  validateOutput,

  postValidate(_input, output) {
    return output;
  },

  /** 兜底：用模板 *_instruction 字段拼成步骤（见 llm-spec §4.4） */
  degrade(input) {
    const p = input.pose;
    const steps = [
      p.body_instruction,
      p.hand_instruction,
      `${p.face_instruction} ${p.eye_instruction}`.trim(),
      p.camera_position_instruction,
      p.composition_instruction,
    ].filter((s) => s && s.length > 0);
    return { steps, tips: input.pose.tips ?? [] };
  },
};
