import { describe, it, expect, beforeAll, afterAll } from "vitest";
import type { FastifyInstance } from "fastify";
import { buildApp } from "../src/app.js";
import { loadConfig } from "../src/config.js";

/**
 * 集成测试：不配置任何 API Key，provider 调用必然失败，
 * 验证两个接口会优雅降级（degraded=true）而非报错——即「LLM 挂了核心仍可用」。
 */
describe("app 集成", () => {
  let app: FastifyInstance;

  beforeAll(async () => {
    process.env.APP_TOKENS = ""; // 本地测试豁免鉴权
    process.env.ANTHROPIC_API_KEY = "";
    process.env.OPENAI_API_KEY = "";
    app = await buildApp(loadConfig());
    await app.ready();
  });

  afterAll(async () => {
    await app.close();
  });

  it("/healthz 返回 ok 与 provider 配置", async () => {
    const res = await app.inject({ method: "GET", url: "/healthz" });
    expect(res.statusCode).toBe(200);
    expect(res.json().status).toBe("ok");
  });

  it("/v1/style-recommend 入参非法返回 400", async () => {
    const res = await app.inject({
      method: "POST",
      url: "/v1/style-recommend",
      payload: { scene_id: "cafe" },
    });
    expect(res.statusCode).toBe(400);
    expect(res.json().error).toBe("invalid_input");
  });

  it("/v1/style-recommend 无 Key 时降级返回排序", async () => {
    const res = await app.inject({
      method: "POST",
      url: "/v1/style-recommend",
      payload: {
        scene_id: "cafe",
        person_type: "female",
        candidate_styles: [
          { style_id: "korean", style_name: "韩系风格", base_score: 6 },
          { style_id: "japanese", style_name: "日系清新", base_score: 9 },
        ],
      },
    });
    expect(res.statusCode).toBe(200);
    const body = res.json();
    expect(body.degraded).toBe(true);
    expect(body.recommendations[0].style_id).toBe("japanese"); // base_score 高者在前
  });
});
