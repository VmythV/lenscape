import {
  type LlmProvider,
  type LlmRequest,
  type LlmResponse,
  LlmProviderError,
} from "./types.js";

/**
 * 把「主 + 备」provider 串成一个对上层透明的 LlmProvider：
 * 主失败时按顺序切换到备用，全部失败则抛出聚合错误（见 docs/architecture.md §5.3）。
 *
 * FailoverProvider 本身也是 LlmProvider，业务层拿到它即可，不感知降级逻辑。
 */
export class FailoverProvider implements LlmProvider {
  readonly name = "failover";
  private readonly chain: LlmProvider[];

  constructor(
    primary: LlmProvider,
    fallbacks: LlmProvider[],
    private readonly timeoutMs: number,
    private readonly onAttempt?: (provider: string, ok: boolean, error?: unknown) => void,
  ) {
    this.chain = [primary, ...fallbacks];
  }

  async complete(req: LlmRequest): Promise<LlmResponse> {
    const errors: unknown[] = [];

    for (const provider of this.chain) {
      const controller = new AbortController();
      const timer = setTimeout(() => controller.abort(), this.timeoutMs);
      try {
        const res = await provider.complete(req, controller.signal);
        this.onAttempt?.(provider.name, true);
        return res;
      } catch (err) {
        this.onAttempt?.(provider.name, false, err);
        errors.push(err);
      } finally {
        clearTimeout(timer);
      }
    }

    throw new LlmProviderError(
      "failover",
      `all providers failed: ${errors.map((e) => (e instanceof Error ? e.message : String(e))).join(" | ")}`,
      errors,
    );
  }
}
