import { readFileSync, statSync } from "node:fs";
import vm from "node:vm";

const html = readFileSync("index.html", "utf8");
const size = statSync("index.html").size;
if (size > 5 * 1024 * 1024) throw new Error(`index.html too large: ${size} bytes`);
const m = html.match(/<script>([\s\S]*)<\/script>/);
if (!m) throw new Error("inline <script> not found");
new vm.Script(m[1]); // throws on syntax error
for (const id of ["photo", "rail", "pants", "shoes", "seasons", "bars"]) {
  if (!html.includes(`id="${id}"`)) throw new Error(`missing #${id}`);
}
if (/<script[^>]+src=/.test(html)) throw new Error("external scripts are blocked by the CSP in _headers");
console.log(`check ok (${Math.round(size / 1024)} KB)`);
