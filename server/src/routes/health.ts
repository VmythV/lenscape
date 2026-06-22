import type { FastifyInstance } from "fastify";
import type { Services } from "../app.js";

export function registerHealthRoute(app: FastifyInstance, services: Services): void {
  app.get("/healthz", async () => {
    return {
      status: "ok",
      llm: {
        primary: services.config.llm.primary,
        fallbacks: services.config.llm.fallbacks,
      },
    };
  });
}
