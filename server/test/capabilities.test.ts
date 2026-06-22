import { describe, it, expect } from "vitest";
import { InMemoryCache, cacheKey } from "../src/lib/cache.js";
import { runCapability, type RunContext } from "../src/capabilities/runner.js";
import { styleRecommendSpec } from "../src/capabilities/styleRecommend.js";
import { guidanceCopySpec } from "../src/capabilities/guidanceCopy.js";
import type { LlmProvider, LlmRequest, LlmResponse } from "../src/llm/types.js";
import { LlmProviderError } from "../src/llm/types.js";

function ctx(provider: LlmProvider): RunContext {
  return {
    provider,
    cache: new InMemoryCache(60_000),
    contentVersion: "1",
    log: () => {},
  };
}

const styleInput = {
  scene_id: "cafe",
  scene_name: "咖啡店",
  person_type: "female",
  person_name: "女生",
  candidate_styles: [
    { style_id: "korean", style_name: "韩系风格", base_score: 6 },
    { style_id: "japanese", style_name: "日系清新", base_score: 5 },
  ],
};

class StubProvider implements LlmProvider {
  readonly name = "stub";
  constructor(private readonly json: unknown) {}
  async complete(_req: LlmRequest): Promise<LlmResponse> {
    return { json: this.json, usage: { inputTokens: 1, outputTokens: 1 }, provider: "stub:x" };
  }
}

class FailingProvider implements LlmProvider {
  readonly name = "failing";
  async complete(): Promise<LlmResponse> {
    throw new LlmProviderError(this.name, "boom");
  }
}

describe("cacheKey", () => {
  it("等价输入（键顺序不同/含空值）得到同一 key", () => {
    const a = cacheKey("c", "1", { x: 1, y: [2, 3], z: undefined });
    const b = cacheKey("c", "1", { y: [2, 3], x: 1 });
    expect(a).toBe(b);
  });
  it("contentVersion 变化使 key 失效", () => {
    expect(cacheKey("c", "1", { x: 1 })).not.toBe(cacheKey("c", "2", { x: 1 }));
  });
});

describe("style-recommend 能力", () => {
  it("正常返回并过滤候选外 style_id", async () => {
    const provider = new StubProvider({
      recommendations: [
        { style_id: "japanese", reason: "咖啡店光线柔和适合日系" },
        { style_id: "INVALID", reason: "越界应被剔除" },
      ],
    });
    const res = await runCapability(styleRecommendSpec, styleInput, ctx(provider));
    expect(res.degraded).toBe(false);
    expect(res.recommendations.map((r) => r.style_id)).toEqual(["japanese"]);
  });

  it("LLM 失败时降级，按 base_score 排序", async () => {
    const res = await runCapability(styleRecommendSpec, styleInput, ctx(new FailingProvider()));
    expect(res.degraded).toBe(true);
    expect(res.recommendations[0]?.style_id).toBe("korean");
  });

  it("输出不合 schema（reason 超长）时降级", async () => {
    const provider = new StubProvider({
      recommendations: [{ style_id: "korean", reason: "x".repeat(100) }],
    });
    const res = await runCapability(styleRecommendSpec, styleInput, ctx(provider));
    expect(res.degraded).toBe(true);
  });
});

const guidanceInput = {
  style: { style_id: "korean", style_name: "韩系风格" },
  person: { person_type: "female", person_name: "女生" },
  scene: { scene_id: "cafe", scene_name: "咖啡店", keep_background: true },
  pose: {
    pose_id: "cafe_sit_001",
    pose_name: "韩系咖啡店坐姿照",
    body_instruction: "坐在靠窗位置，身体微微侧向拍摄方向。",
    hand_instruction: "一只手放桌面，另一只手可拿咖啡杯。",
    face_instruction: "脸部朝向窗外。",
    eye_instruction: "眼神看向窗外，不直视镜头。",
    position_instruction: "人物在画面中间偏右。",
    camera_position_instruction: "拍摄者站在人物斜前方 45 度。",
    camera_height: "chest",
    camera_angle: "top_down",
    camera_direction: "front_45",
    camera_distance: "near",
    subject_position: "right_third",
    subject_ratio: "subject_first",
    composition_instruction: "竖屏构图，保留窗户和桌面。",
    tips: ["减少桌面杂物"],
  },
};

describe("guidance-copy 能力", () => {
  it("LLM 失败时用模板字段拼出兜底步骤", async () => {
    const res = await runCapability(guidanceCopySpec, guidanceInput, ctx(new FailingProvider()));
    expect(res.degraded).toBe(true);
    expect(res.steps.length).toBeGreaterThanOrEqual(4);
    expect(res.steps[0]).toContain("靠窗");
  });
});
