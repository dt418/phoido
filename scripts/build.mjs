import { mkdirSync, rmSync, copyFileSync } from "node:fs";

rmSync("dist", { recursive: true, force: true });
mkdirSync("dist");
for (const f of ["index.html", "_headers"]) copyFileSync(f, `dist/${f}`);
console.log("dist/ ready");
