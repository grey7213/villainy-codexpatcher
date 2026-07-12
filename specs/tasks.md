# v1.4.7 Upgrade Tasks

- [x] Audit repository rules, Git state, current customizations, and build commands.
- [x] Fetch and inspect upstream v1.4.7.
- [x] Preserve all v1.4.6 customizations on a dedicated backup branch.
- [x] Fast-forward `main` to official v1.4.7.
- [x] Merge the private customization snapshot and resolve conflicts.
- [x] Verify version metadata and retained custom behavior.
- [x] Run Python tests, frontend build, and Worker tests.
- [x] Open the rebuilt Web UI and perform visual verification.
- [x] Record final verification results and remaining risks here.

## Verification results

- Version endpoint and source metadata report `1.4.7`.
- Frontend production build passed: Vite transformed 4163 modules and generated `dist/` successfully; only the existing large-chunk warning remains.
- Worker tests passed: 17/17.
- Python core subset passed: 56/56.
- Python full suite result on native Windows: 69 passed, 4 skipped, 36 failed. Failures are confined to upstream tests that assume POSIX `HOME` semantics or a compatible `bash` on `PATH`; no failed test targets the merge-resolved frontend files.
- Visual check passed at `http://127.0.0.1:8765/`: Villain Y branding, v1.4.7 badge, centered no-ad layout, Codex App launch guidance, and Villain y WeChat QR popover were all present. Browser console showed no warnings or errors during the inspected flow.

## Remaining risk

- The complete upstream Python suite should also be run in Linux/macOS or a CI environment that matches its POSIX assumptions for a fully green cross-platform signal.
