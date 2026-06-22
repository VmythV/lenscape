import { Ajv, type ValidateFunction, type Schema } from "ajv";

/**
 * 统一的 JSON Schema 校验封装。用于：
 *  1. 入参校验（请求体）
 *  2. LLM 输出再校验（不信任 provider 自带保证，见 docs/llm-spec.md §2/§5）
 */
const ajv = new Ajv({ allErrors: true, removeAdditional: false, strict: false });

export interface ValidationResult<T> {
  ok: boolean;
  data?: T;
  errors?: string[];
}

export function compile<T>(schema: Schema): (data: unknown) => ValidationResult<T> {
  const validate = ajv.compile(schema) as ValidateFunction;
  return (data: unknown): ValidationResult<T> => {
    if (validate(data)) {
      return { ok: true, data: data as T };
    }
    const errors = (validate.errors ?? []).map(
      (e) => `${e.instancePath || "(root)"} ${e.message ?? "invalid"}`,
    );
    return { ok: false, errors };
  };
}
