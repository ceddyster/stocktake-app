# Stocktaking Mobile App

## Working rules
- **`Stocktake App Deploy.dc.html` is the live app and the source of truth.** Make all app edits here.
- `Stocktake Setup.dc.html` is the older annotated desktop prototype (app inside a drawn iPhone frame). Do not treat it as current.
- **Do NOT rebuild `deploy/index.html` until the user explicitly asks.** We edit the app across several turns, then bundle one fresh deploy folder at the end.

## Stack
- Live sync via Supabase (REST). Credentials are inlined in the app file's `SB` config.
- Per-device state persists in localStorage under key `stocktake.setup.v1`.
- Google Drive UI is simulated only — not wired to real Drive.

## Deploy
- `deploy/` is a static bundle (index.html + manifest + icons) for Netlify.
- Site: stocktakeapp.netlify.app. User deploys manually (drag `deploy/` into Netlify).
- **Two-step build — ALWAYS run both.** The bundler gzip-compresses large assets and decompresses them at load time via `DecompressionStream`, which older iOS Safari (< 16.4) lacks — there it leaves the runtime script gzipped and the JS parser dies on `\u001f`, so the page renders raw `{{ template holes }}`. So after every bundle, inflate the compressed assets in place so the runtime never needs `DecompressionStream`:
  1. `super_inline_html(Stocktake App Deploy.dc.html → deploy/index.html)`
  2. Run the inflate post-process (`run_script`): in `deploy/index.html`, parse the `<script type="__bundler/manifest">` JSON; for each entry with `compressed:true`, gunzip its base64 `data` with `DecompressionStream('gzip')`, re-base64 the raw bytes, set `compressed:false`; write the manifest back. Verify 0 entries remain compressed and the page renders (no holes, no `[bundle]` error).
