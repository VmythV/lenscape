/**
 * 集中读取环境变量。所有可调项（provider、模型、端点、Key、限流、缓存）走配置，
 * 不写死代码（见 docs/architecture.md §4.2）。
 */

function str(name: string, fallback?: string): string {
  const v = process.env[name];
  if (v === undefined || v === "") {
    if (fallback !== undefined) return fallback;
    return "";
  }
  return v;
}

function int(name: string, fallback: number): number {
  const v = process.env[name];
  if (v === undefined || v === "") return fallback;
  const n = Number.parseInt(v, 10);
  return Number.isFinite(n) ? n : fallback;
}

function list(name: string, fallback: string[] = []): string[] {
  const v = process.env[name];
  if (!v) return fallback;
  return v
    .split(",")
    .map((s) => s.trim())
    .filter(Boolean);
}

export interface ProviderConfig {
  apiKey: string;
  baseUrl: string;
  model: string;
  /** Anthropic 专用 */
  version?: string;
}

export interface Config {
  port: number;
  host: string;
  logLevel: string;
  appTokens: string[];
  rateLimit: { max: number; window: string };
  cache: { ttlMs: number; contentVersion: string };
  llm: {
    primary: string;
    fallbacks: string[];
    timeoutMs: number;
    anthropic: ProviderConfig;
    openai: ProviderConfig;
  };
}

export function loadConfig(): Config {
  return {
    port: int("PORT", 8787),
    host: str("HOST", "0.0.0.0"),
    logLevel: str("LOG_LEVEL", "info"),
    appTokens: list("APP_TOKENS"),
    rateLimit: {
      max: int("RATE_LIMIT_MAX", 60),
      window: str("RATE_LIMIT_WINDOW", "1 minute"),
    },
    cache: {
      ttlMs: int("CACHE_TTL_MS", 7 * 24 * 60 * 60 * 1000),
      contentVersion: str("CONTENT_VERSION", "1"),
    },
    llm: {
      primary: str("LLM_PRIMARY", "anthropic"),
      fallbacks: list("LLM_FALLBACKS"),
      timeoutMs: int("LLM_TIMEOUT_MS", 8000),
      anthropic: {
        apiKey: str("ANTHROPIC_API_KEY"),
        baseUrl: str("ANTHROPIC_BASE_URL", "https://api.anthropic.com"),
        model: str("ANTHROPIC_MODEL", "claude-sonnet-4-6"),
        version: str("ANTHROPIC_VERSION", "2023-06-01"),
      },
      openai: {
        apiKey: str("OPENAI_API_KEY"),
        baseUrl: str("OPENAI_BASE_URL", "https://api.openai.com/v1"),
        model: str("OPENAI_MODEL", "gpt-4o-mini"),
      },
    },
  };
}

export type { Config as AppConfig };
