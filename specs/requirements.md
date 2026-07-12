# v1.4.7 Upgrade Requirements

## Goal

Upgrade the current v1.4.6-based private fork to official upstream v1.4.7 without losing the existing Villain Y customization.

## Scope

- Integrate all three upstream commits between tags v1.4.6 and v1.4.7.
- Preserve the 12 existing customized files, including the WeChat image and Windows PowerShell scripts.
- Resolve overlapping frontend changes by behavior, not by wholesale file replacement.
- Record a durable pre-upgrade backup branch.

## Acceptance criteria

- `main` contains upstream v1.4.7 version metadata and functional changes.
- The UI still shows `Villain Y Patcher`, Villain Y contact details, and no upstream ad slots/sponsor links.
- New v1.4.7 launch-command copy behavior and non-conflicting backend/worker fixes remain available.
- Python tests, frontend build, and Worker tests pass, or any environment-only blocker is documented.
- The real Web UI is opened and visually checked after rebuilding.

## Non-goals

- No unrelated refactor or dependency upgrade.
- No deployment, publishing, or remote server changes.
- No alteration of the existing QR image or contact identifiers.
