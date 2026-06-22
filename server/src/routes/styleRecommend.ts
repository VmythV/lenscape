import type { FastifyInstance } from "fastify";
import type { Services } from "../app.js";
import { runCapability } from "../capabilities/runner.js";
import {
  styleRecommendSpec,
  validateInput,
  type StyleRecommendInput,
} from "../capabilities/styleRecommend.js";

export function registerStyleRecommendRoute(app: FastifyInstance, services: Services): void {
  app.post("/v1/style-recommend", async (req, reply) => {
    const parsed = validateInput(req.body);
    if (!parsed.ok || !parsed.data) {
      return reply.code(400).send({ error: "invalid_input", details: parsed.errors });
    }
    const input: StyleRecommendInput = parsed.data;

    const provider = services.factory.resolve((name, ok, error) => {
      app.log.info({ capability: "style-recommend", provider: name, ok, error: errMsg(error) });
    });

    const result = await runCapability(styleRecommendSpec, input, {
      provider,
      cache: services.cache,
      contentVersion: services.config.cache.contentVersion,
      log: (fields) => app.log.info(fields),
    });

    return reply.send(result);
  });
}

function errMsg(error: unknown): string | undefined {
  if (!error) return undefined;
  return error instanceof Error ? error.message : String(error);
}
