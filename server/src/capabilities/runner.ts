import type { LlmProvider } from "../llm/types.js";
import type { JsonSchema } from "../llm/types.js";
import type { ValidationResult } from "../lib/schema.js";
import type { Cache } from "../lib/cache.js";
import { cacheKey } from "../lib/cache.js";

/**
 * 一个 LLM 能力的声明式规格。两个能力（风格推荐 / 指导文案）共用同一执行流程
 * （见 docs/llm-spec.md §5）。
 */
export interface CapabilitySpec<TInput, TOutput> {
  /** 能力名，参与缓存键与日志 */
  name: string;
  /** 结构化输出的工具/schema 名 */
  schemaName: string;
  responseSchema: JsonSchema;
  maxTokens: number;
  temperature: number;
  buildPrompt(input: TInput): { system: string; user: string };
  validateOutput(data: unknown): ValidationResult<TOutput>;
  /** 业务级越界校验/清洗；返回 null 表示不可用，触发降级 */
  postValidate(input: TInput, output: TOutput): TOutput | null;
  /** 兜底数据（LLM 不可用时使用本地静态结果） */
  degrade(input: TInput): TOutput;
}

export interface RunContext {
  provider: LlmProvider;
  cache: Cache;
  contentVersion: string;
  /** 结构化日志回调 */
  log: (fields: Record<string, unknown>) => void;
}

export type RunResult<TOutput> = TOutput & { degraded: boolean };

const MAX_ATTEMPTS = 2; // 首次 + 1 次重试（见 llm-spec §5）

export async function runCapability<TInput, TOutput>(
  spec: CapabilitySpec<TInput, TOutput>,
  input: TInput,
  ctx: RunContext,
): Promise<RunResult<TOutput>> {
  const key = cacheKey(spec.name, ctx.contentVersion, input);

  const cached = ctx.cache.get<TOutput>(key);
  if (cached) {
    ctx.log({ capability: spec.name, cache: "hit", degraded: false });
    return { ...cached, degraded: false };
  }

  const { system, user } = spec.buildPrompt(input);
  let lastError: string | undefined;

  for (let attempt = 1; attempt <= MAX_ATTEMPTS; attempt++) {
    try {
      const res = await ctx.provider.complete({
        system,
        user,
        responseSchema: spec.responseSchema,
        schemaName: spec.schemaName,
        maxTokens: spec.maxTokens,
        temperature: spec.temperature,
      });

      const validated = spec.validateOutput(res.json);
      if (!validated.ok || validated.data === undefined) {
        lastError = `schema: ${validated.errors?.join("; ")}`;
        continue;
      }

      const clean = spec.postValidate(input, validated.data);
      if (clean === null) {
        lastError = "postValidate rejected output";
        continue;
      }

      ctx.cache.set(key, clean);
      ctx.log({
        capability: spec.name,
        cache: "miss",
        degraded: false,
        provider: res.provider,
        attempt,
        inputTokens: res.usage.inputTokens,
        outputTokens: res.usage.outputTokens,
      });
      return { ...clean, degraded: false };
    } catch (err) {
      lastError = err instanceof Error ? err.message : String(err);
    }
  }

  // 全部失败 → 降级兜底
  ctx.log({ capability: spec.name, degraded: true, error: lastError });
  return { ...spec.degrade(input), degraded: true };
}
