import type { FastifyInstance } from "fastify";
import type { Services } from "../app.js";
import { runCapability } from "../capabilities/runner.js";
import {
  guidanceCopySpec,
  validateInput,
  type GuidanceCopyInput,
} from "../capabilities/guidanceCopy.js";

export function registerGuidanceCopyRoute(app: FastifyInstance, services: Services): void {
  app.post("/v1/guidance-copy", async (req, reply) => {
    const parsed = validateInput(req.body);
    if (!parsed.ok || !parsed.data) {
      return reply.code(400).send({ error: "invalid_input", details: parsed.errors });
    }
    const input: GuidanceCopyInput = parsed.data;

    const provider = services.factory.resolve((name, ok, error) => {
      app.log.info({ capability: "guidance-copy", provider: name, ok, error: errMsg(error) });
    });

    const result = await runCapability(guidanceCopySpec, input, {
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
