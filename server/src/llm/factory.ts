import type { Config } from "../config.js";
import { FailoverProvider } from "./failover.js";
import { AnthropicProvider } from "./providers/anthropic.js";
import { OpenAIProvider } from "./providers/openai.js";
import type { LlmProvider } from "./types.js";

/**
 * provider 工厂（见 docs/architecture.md §5.3）。
 * 新增 provider = 在 create() 注册一个分支，业务层零改动。
 */
export class LlmProviderFactory {
  private cache = new Map<string, LlmProvider>();

  constructor(private readonly cfg: Config) {}

  /** 按名字创建（带实例缓存） */
  create(name: string): LlmProvider {
    const cached = this.cache.get(name);
    if (cached) return cached;

    let provider: LlmProvider;
    switch (name) {
      case "anthropic":
        provider = new AnthropicProvider(this.cfg.llm.anthropic);
        break;
      case "openai":
        provider = new OpenAIProvider(this.cfg.llm.openai);
        break;
      default:
        throw new Error(`unknown LLM provider: ${name}`);
    }
    this.cache.set(name, provider);
    return provider;
  }

  /**
   * 业务侧入口：返回带主备降级链的 provider。
   * 主与备由配置（LLM_PRIMARY / LLM_FALLBACKS）决定，运维可随时调整，无需改代码。
   */
  resolve(
    onAttempt?: (provider: string, ok: boolean, error?: unknown) => void,
  ): LlmProvider {
    const primary = this.create(this.cfg.llm.primary);
    const fallbacks = this.cfg.llm.fallbacks
      .filter((n) => n !== this.cfg.llm.primary)
      .map((n) => this.create(n));
    return new FailoverProvider(primary, fallbacks, this.cfg.llm.timeoutMs, onAttempt);
  }
}
