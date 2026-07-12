# Project Working Notes

## Scope

- Python CLI and FastAPI backend live under `codex_session_patcher/` and `web/backend/`.
- Vue/Vite frontend lives under `web/frontend/`.
- Cloudflare Worker advertising/cooperation service lives under `services/muggle-leads/`.

## Local customization boundary

- Keep the private brand name `Villain Y Patcher` and the `private console` badge.
- Keep the Villain Y WeChat QR/contact flow and the PowerShell start/stop scripts.
- Keep the public upstream advertising slots disabled in the private frontend; main content remains centered with a 960px maximum width.
- Upstream fixes outside this private-brand boundary should be retained during upgrades.

## Commands

- Python tests: `python -m pytest`
- Frontend build: `npm run build` from `web/frontend/`
- Worker tests: `npm test` from `services/muggle-leads/`
- Windows web start/stop: `./start-web.ps1` and `./stop-web.ps1`

## Codebase map

- Version: `pyproject.toml`, `codex_session_patcher/__init__.py`
- Main frontend shell: `web/frontend/src/App.vue`
- Cooperation/contact UI: `web/frontend/src/components/CooperationPanel.vue`
- Help and launch commands: `web/frontend/src/components/HelpPanel.vue`, `PromptEnhancePanel.vue`
- Locales: `web/frontend/src/locales/`
- Shared shell launcher logic: `scripts/web-common.sh`

## Pitfalls

- `core.autocrlf=true` may report LF-to-CRLF warnings; avoid whole-file formatting churn during merges.
- Do not restore upstream GitHub/X/sponsor links or remote ad-slot loading into the private frontend.
- `web/frontend/dist/`, `node_modules/`, caches, and egg-info are generated artifacts and should be rebuilt rather than merged.
- On this Windows host, the first `bash` on `PATH` is the OpenSSH/WindowsApps shim, not Git Bash. Shell-script tests must explicitly prepend `C:\Program Files\Git\bin` or call that Bash by absolute path.
- Native Windows Python does not make `pathlib.Path.home()` follow a test-only `HOME` override while `USERPROFILE` is set. The upstream CTF installer tests therefore report Windows-only HOME isolation failures even though the unaffected core suite passes.

## Upgrade record

- 2026-07-10: upgraded upstream v1.4.6 to v1.4.7. The original customization snapshot is preserved on branch `backup/pre-v1.4.7-villainy-20260710`.
