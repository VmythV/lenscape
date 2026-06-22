import type { ProviderConfig } from "../../config.js";
import {
  type LlmProvider,
  type LlmRequest,
  type LlmResponse,
  LlmProviderError,
} from "../types.js";

/**
 * Anthropic Messages API 实现。
 * 结构化输出通过「强制工具调用」实现：定义一个 input_schema = 目标 Schema 的工具，
 * 用 tool_choice 强制模型调用它，从 tool_use.input 取结构化结果（见 docs/llm-spec.md §2）。
 */
export class AnthropicProvider implements LlmProvider {
  readonly name = "anthropic";

  constructor(private readonly cfg: ProviderConfig) {}

  async complete(req: LlmRequest, signal?: AbortSignal): Promise<LlmResponse> {
    if (!this.cfg.apiKey) {
      throw new LlmProviderError(this.name, "missing ANTHROPIC_API_KEY");
    }

    const structured = Boolean(req.responseSchema);
    const toolName = req.schemaName ?? "result";

    const body: Record<string, unknown> = {
      model: this.cfg.model,
      max_tokens: req.maxTokens,
      temperature: req.temperature,
      system: req.system,
      messages: [{ role: "user", content: req.user }],
    };

    if (structured) {
      body.tools = [
        {
          name: toolName,
          description: "Return the result strictly following the schema.",
          input_schema: req.responseSchema,
        },
      ];
      body.tool_choice = { type: "tool", name: toolName };
    }

    let res: Response;
    try {
      res = await fetch(`${this.cfg.baseUrl}/v1/messages`, {
        method: "POST",
        headers: {
          "content-type": "application/json",
          "x-api-key": this.cfg.apiKey,
          "anthropic-version": this.cfg.version ?? "2023-06-01",
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

    const data = (await res.json()) as AnthropicResponse;
    const usage = {
      inputTokens: data.usage?.input_tokens ?? 0,
      outputTokens: data.usage?.output_tokens ?? 0,
    };
    const providerTag = `${this.name}:${this.cfg.model}`;

    if (structured) {
      const toolUse = data.content?.find((c) => c.type === "tool_use");
      if (!toolUse || toolUse.input === undefined) {
        throw new LlmProviderError(this.name, "no tool_use block in response");
      }
      return { json: toolUse.input, usage, provider: providerTag };
    }

    const text = data.content
      ?.filter((c) => c.type === "text")
      .map((c) => c.text ?? "")
      .join("");
    return { text: text ?? "", usage, provider: providerTag };
  }
}

interface AnthropicResponse {
  content?: Array<{
    type: string;
    text?: string;
    input?: unknown;
  }>;
  usage?: { input_tokens?: number; output_tokens?: number };
}
