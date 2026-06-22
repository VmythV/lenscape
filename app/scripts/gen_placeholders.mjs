// 为种子数据中引用到的每个图片路径生成占位 PNG（占位阶段用）。
// 真实素材（#8 AI 文生图 + 人工审核）产出后，按相同路径覆盖即可。
//
// 用法：node scripts/gen_placeholders.mjs
import { readFileSync, mkdirSync, writeFileSync, existsSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

const root = join(dirname(fileURLToPath(import.meta.url)), "..");
const dataDir = join(root, "assets", "data");

// 1x1 灰色 PNG（占位）。
const PLACEHOLDER_PNG = Buffer.from(
  "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAC0lEQVR42mNk+M9QDwADhgGAWjR9awAAAABJRU5ErkJggg==",
  "base64",
);

function collectPaths() {
  const paths = new Set();
  const styles = JSON.parse(readFileSync(join(dataDir, "styles.json"), "utf8"));
  const scenes = JSON.parse(readFileSync(join(dataDir, "scenes.json"), "utf8"));
  const poses = JSON.parse(readFileSync(join(dataDir, "poses.json"), "utf8"));

  for (const s of styles) for (const p of s.sample_images ?? []) paths.add(p);
  for (const s of scenes) for (const p of s.example_images ?? []) paths.add(p);
  for (const p of poses) {
    if (p.illustration_image) paths.add(p.illustration_image);
    if (p.pose_outline_image) paths.add(p.pose_outline_image);
  }
  return [...paths];
}

let created = 0;
let skipped = 0;
for (const rel of collectPaths()) {
  const abs = join(root, "assets", rel);
  if (existsSync(abs)) {
    skipped++;
    continue;
  }
  mkdirSync(dirname(abs), { recursive: true });
  writeFileSync(abs, PLACEHOLDER_PNG);
  created++;
}

console.log(`placeholder images: created ${created}, skipped ${skipped}`);
