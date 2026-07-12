# v1.4.7 Upgrade Design

## Source graph

- Common base: `v1.4.6` (`553ff4f`).
- Upstream target: `v1.4.7` (`20bbdd0`).
- Private customization snapshot: `backup/pre-v1.4.7-villainy-20260710` (`e18d1df`).

## Merge strategy

1. Commit the dirty v1.4.6 workspace to a dedicated backup branch.
2. Fast-forward `main` to the official v1.4.7 tag.
3. Merge the backup branch with `--no-commit` and resolve overlaps manually.
4. Prefer upstream v1.4.7 for version files, Worker/admin fixes, `AdSlot.vue`, and `PromptEnhancePanel.vue`.
5. Prefer private behavior in `App.vue` for branding, contact links, sponsorship removal, and ad-slot removal.
6. Combine both sides in `HelpPanel.vue` and locale files so new v1.4.7 copy/help text is retained with private branding.

## Verification

- Confirm Git ancestry includes v1.4.7 and the private snapshot.
- Run `python -m pytest`.
- Run `npm run build` in `web/frontend/`.
- Run `npm test` in `services/muggle-leads/`.
- Start the Web UI and inspect desktop output for branding, QR image, launch-command copy UI, and absence of ad columns.
