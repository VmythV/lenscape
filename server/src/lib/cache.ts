import { createHash } from "node:crypto";

/**
 * 进程内 TTL 缓存。量小先用内存，增长后可替换为 Redis（接口保持不变）。
 * 见 docs/llm-spec.md §6。
 */
export interface Cache {
  get<T>(key: string): T | undefined;
  set<T>(key: string, value: T): void;
}

interface Entry {
  value: unknown;
  expiresAt: number;
}

export class InMemoryCache implements Cache {
  private store = new Map<string, Entry>();

  constructor(private readonly ttlMs: number) {}

  get<T>(key: string): T | undefined {
    const entry = this.store.get(key);
    if (!entry) return undefined;
    if (entry.expiresAt <= Date.now()) {
      this.store.delete(key);
      return undefined;
    }
    return entry.value as T;
  }

  set<T>(key: string, value: T): void {
    this.store.set(key, { value, expiresAt: Date.now() + this.ttlMs });
  }
}

/**
 * 规范化对象：递归排序对象键、剔除 undefined/null，保证等价输入得到同一序列化结果。
 */
function canonical(value: unknown): unknown {
  if (Array.isArray(value)) return value.map(canonical);
  if (value && typeof value === "object") {
    const out: Record<string, unknown> = {};
    for (const key of Object.keys(value as Record<string, unknown>).sort()) {
      const v = (value as Record<string, unknown>)[key];
      if (v === undefined || v === null) continue;
      out[key] = canonical(v);
    }
    return out;
  }
  return value;
}

/**
 * cache_key = sha256(capability + "|" + contentVersion + "|" + canonical_json(input))
 * 见 docs/llm-spec.md §6。
 */
export function cacheKey(
  capability: string,
  contentVersion: string,
  input: unknown,
): string {
  const payload = `${capability}|${contentVersion}|${JSON.stringify(canonical(input))}`;
  return createHash("sha256").update(payload).digest("hex");
}
