import { compile } from "../lib/schema.js";
import type { CapabilitySpec } from "./runner.js";

/** 请求体（见 docs/llm-spec.md §3.2） */
export interface StyleRecommendInput {
  scene_id: string;
  scene_name?: string;
  scene_description?: string;
  person_type: string;
  person_name?: string;
  user_note?: string;
  candidate_styles: Array<{ style_id: string; style_name: string; base_score: number }>;
}

export interface StyleRecommendOutput {
  recommendations: Array<{ style_id: string; reason: string }>;
}

/** 入参 Schema */
export const inputSchema = {
  type: "object",
  additionalProperties: false,
  required: ["scene_id", "person_type", "candidate_styles"],
  properties: {
    scene_id: { type: "string", minLength: 1 },
    scene_name: { type: "string" },
    scene_description: { type: "string" },
    person_type: { type: "string", minLength: 1 },
    person_name: { type: "string" },
    user_note: { type: "string", maxLength: 200 },
    candidate_styles: {
      type: "array",
      minItems: 1,
      items: {
        type: "object",
        additionalProperties: false,
        required: ["style_id", "style_name", "base_score"],
        properties: {
          style_id: { type: "string", minLength: 1 },
          style_name: { type: "string", minLength: 1 },
          base_score: { type: "number" },
        },
      },
    },
  },
} as const;

/** LLM 结构化输出 Schema（见 llm-spec §3.3） */
const outputSchema = {
  type: "object",
  additionalProperties: false,
  required: ["recommendations"],
  properties: {
    recommendations: {
      type: "array",
      minItems: 1,
      items: {
        type: "object",
        additionalProperties: false,
        required: ["style_id", "reason"],
        properties: {
          style_id: { type: "string", minLength: 1 },
          reason: { type: "string", maxLength: 40 },
        },
      },
    },
  },
} as const;

export const validateInput = compile<StyleRecommendInput>(inputSchema);
const validateOutput = compile<StyleRecommendOutput>(outputSchema);

export const styleRecommendSpec: CapabilitySpec<StyleRecommendInput, StyleRecommendOutput> = {
  name: "style-recommend",
  schemaName: "style_recommendations",
  responseSchema: outputSchema as unknown as Record<string, unknown>,
  maxTokens: 512,
  temperature: 0.3,

  buildPrompt(input) {
    const system = [
      "你是镜界 App 的拍摄风格推荐助手。你的唯一任务：在给定的候选风格中，结合拍摄场景、人物类型和用户描述，做重新排序并给出一句简短理由。",
      "",
      "严格规则：",
      "1. 只能从候选风格里选，禁止引入候选之外的任何风格。",
      "2. 按推荐优先级从高到低排序，最相关的排第一。",
      "3. 每条理由不超过 40 字，必须具体说明“为什么这个场景/人物适合该风格”，不要写空话。",
      "4. 只输出结构化结果，不要输出多余文字。",
    ].join("\n");

    const candidates = input.candidate_styles
      .map((c) => `- ${c.style_id} ${c.style_name}`)
      .join("\n");

    const user = [
      `场景：${input.scene_name ?? input.scene_id}${input.scene_description ? `（${input.scene_description}）` : ""}`,
      `人物类型：${input.person_name ?? input.person_type}`,
      `用户描述：${input.user_note?.trim() || "无"}`,
      "",
      "候选风格：",
      candidates,
      "",
      "请对以上候选风格重新排序并给出理由。",
    ].join("\n");

    return { system, user };
  },

  validateOutput,

  /** 业务级越界：剔除候选外 style_id；去重；空则判不可用 */
  postValidate(input, output) {
    const allowed = new Set(input.candidate_styles.map((c) => c.style_id));
    const seen = new Set<string>();
    const recommendations = output.recommendations.filter((r) => {
      if (!allowed.has(r.style_id) || seen.has(r.style_id)) return false;
      seen.add(r.style_id);
      return true;
    });
    if (recommendations.length === 0) return null;
    return { recommendations };
  },

  /** 兜底：按 base_score 排序，理由留空 */
  degrade(input) {
    const recommendations = [...input.candidate_styles]
      .sort((a, b) => b.base_score - a.base_score)
      .map((c) => ({ style_id: c.style_id, reason: "" }));
    return { recommendations };
  },
};
