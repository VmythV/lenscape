import type { ProviderConfig } from "../../config.js";
import {
  type LlmProvider,
  type LlmRequest,
  type LlmResponse,
  LlmProviderError,
} from "../types.js";

/**
 * OpenAI 协议（Chat Completions）实现。
 * 同样适用于「兼容 OpenAI 协议」的第三方端点（国产模型、自建 vLLM/Ollama），
 * 只需改 baseUrl 与 model。
 *
 * 结构化输出用 response_format: json_schema（strict）。若端点不支持，可降级为
 * json_object —— 这里优先用 json_schema，由后端再做一次 Schema 校验兜底。
 */
export class OpenAIProvider implements LlmProvider {
  readonly name = "openai";

  constructor(private readonly cfg: ProviderConfig) {}

  async complete(req: LlmRequest, signal?: AbortSignal): Promise<LlmResponse> {
    if (!this.cfg.apiKey) {
      throw new LlmProviderError(this.name, "missing OPENAI_API_KEY");
    }

    const structured = Boolean(req.responseSchema);
    const body: Record<string, unknown> = {
      model: this.cfg.model,
      max_tokens: req.maxTokens,
      temperature: req.temperature,
      messages: [
        { role: "system", content: req.system },
        { role: "user", content: req.user },
      ],
    };

    if (structured) {
      body.response_format = {
        type: "json_schema",
        json_schema: {
          name: req.schemaName ?? "result",
          schema: req.responseSchema,
          strict: true,
        },
      };
    }

    let res: Response;
    try {
      res = await fetch(`${this.cfg.baseUrl}/chat/completions`, {
        method: "POST",
        headers: {
          "content-type": "application/json",
          authorization: `Bearer ${this.cfg.apiKey}`,
        },
        body: JSON.stringify(body),
        signal,
      });
    } catch (err) {
      throw new LlmProviderError(this.name, "network error", err);
    }

    if (!res.ok) {
      const detail = await res.text().catch(() => "");
      throw new LlmProviderError(this.name, `HTTP ${res.status}: ${detail.slice(0, 300)}`);
    }

    const data = (await res.json()) as OpenAIResponse;
    const usage = {
      inputTokens: data.usage?.prompt_tokens ?? 0,
      outputTokens: data.usage?.completion_tokens ?? 0,
    };
    const providerTag = `${this.name}:${this.cfg.model}`;
    const content = data.choices?.[0]?.message?.content ?? "";

    if (structured) {
      let json: unknown;
      try {
        json = JSON.parse(content);
      } catch (err) {
        throw new LlmProviderError(this.name, "response is not valid JSON", err);
      }
      return { json, usage, provider: providerTag };
    }

    return { text: content, usage, provider: providerTag };
  }
}

interface OpenAIResponse {
  choices?: Array<{ message?: { content?: string } }>;
  usage?: { prompt_tokens?: number; completion_tokens?: number };
}
