import Fastify, { type FastifyInstance } from "fastify";
import rateLimit from "@fastify/rate-limit";
import type { Config } from "./config.js";
import { InMemoryCache, type Cache } from "./lib/cache.js";
import { LlmProviderFactory } from "./llm/factory.js";
import { registerHealthRoute } from "./routes/health.js";
import { registerStyleRecommendRoute } from "./routes/styleRecommend.js";
import { registerGuidanceCopyRoute } from "./routes/guidanceCopy.js";

export interface Services {
  config: Config;
  cache: Cache;
  factory: LlmProviderFactory;
}

/**
 * 构建 Fastify 应用（与监听分离，便于测试）。
 * 横切能力：鉴权、限流、统一错误（见 docs/architecture.md §4.4）。
 */
export async function buildApp(config: Config): Promise<FastifyInstance> {
  const app = Fastify({
    logger: { level: config.logLevel },
    // 不在日志里打印请求体，避免记录用户文字描述（脱敏）
    disableRequestLogging: true,
  });

  const services: Services = {
    config,
    cache: new InMemoryCache(config.cache.ttlMs),
    factory: new LlmProviderFactory(config),
  };

  await app.register(rateLimit, {
    max: config.rateLimit.max,
    timeWindow: config.rateLimit.window,
  });

  // 应用级 token 鉴权（防滥用，非用户身份）。/healthz 豁免。
  app.addHook("onRequest", async (req, reply) => {
    if (req.url === "/healthz") return;
    if (config.appTokens.length === 0) return; // 未配置则不校验（本地开发）
    const auth = req.headers.authorization ?? "";
    const token = auth.startsWith("Bearer ") ? auth.slice(7) : "";
    if (!config.appTokens.includes(token)) {
      reply.code(401).send({ error: "unauthorized" });
    }
  });

  registerHealthRoute(app, services);
  registerStyleRecommendRoute(app, services);
  registerGuidanceCopyRoute(app, services);

  return app;
}
