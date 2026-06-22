/**
 * provider 无关的 LLM 抽象（见 docs/architecture.md §5）。
 * 业务层只依赖这些类型，不感知具体厂商。
 */

export type JsonSchema = Record<string, unknown>;

/** 与厂商无关的规范化请求 */
export interface LlmRequest {
  system: string;
  user: string;
  /** 需要结构化输出时提供；各 provider 内部用各自机制保证 JSON */
  responseSchema?: JsonSchema;
  /** 结构化输出时作为工具/函数名 */
  schemaName?: string;
  maxTokens: number;
  temperature: number;
}

export interface LlmUsage {
  inputTokens: number;
  outputTokens: number;
}

/** 与厂商无关的规范化响应 */
export interface LlmResponse {
  /** 若请求了结构化输出，解析后的对象 */
  json?: unknown;
  /** 纯文本输出 */
  text?: string;
  usage: LlmUsage;
  /** 实际命中的 provider/model，便于观测 */
  provider: string;
}

export interface LlmProvider {
  readonly name: string;
  complete(req: LlmRequest, signal?: AbortSignal): Promise<LlmResponse>;
}

/** provider 调用失败统一抛出，便于 FailoverProvider 捕获并切换 */
export class LlmProviderError extends Error {
  constructor(
    public readonly provider: string,
    message: string,
    public override readonly cause?: unknown,
  ) {
    super(`[${provider}] ${message}`);
    this.name = "LlmProviderError";
  }
}
