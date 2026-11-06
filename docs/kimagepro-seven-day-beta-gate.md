# KimagePro: seven-day beta release gate

Planning start: 2026-11-06. Target review: 2026-11-13.

This is a **time-boxed, limited-scope Windows beta candidate**, not a promise that the complete CorelDRAW-style feature roadmap can ship in seven days. A release is permitted only after the gates below pass. Work is tracked on draft PR #3 until validation is complete.

## Freeze the beta scope

Include only existing, working image-editing functionality plus the Multipage features already available on the development branch:

- KimagePro branding and update checking **off by default**, with explicit manual opt-in.
- Existing raster/image editing and established shortcuts, without regressions.
- Artboard-backed Multipage page creation, duplication, naming, reordering, page size, margins/bleed metadata and saving/reopening.
- Page Up / Page Down create pages in Multipage, without changing normal image-workspace scrolling or text-input behavior.
- Loose-root object page associations, including atomic multi-object assignment and a read-only page/pasteboard inventory.
- Existing alignment shortcuts and native paste-in-place, with known limitations clearly documented.
- Existing rasterized multipage PDF export; do not claim production print/press readiness.

Explicitly **defer** to later releases: independent non-artboard page architecture, fully interactive infinite pasteboard, complete vector engine integration, PowerClip, print-production TrimBox/BleedBox/CropBox fidelity, master pages, imposition, and advanced automated exports. Do not silently substitute partial implementations.

## Quality gates — required before calling it a beta

1. Rustfmt and Clippy pass; all Linux test and corpus gates pass.
2. Windows unit **and** integration tests pass; a Windows release application compiles once at the beta-candidate stage (no repeated installer builds during routine feature edits).
3. Manual Windows GUI smoke test covers startup, create/open/save/reopen, image-editing tools, undo/redo, page creation/reorder/delete, switching workspaces, alignment shortcuts, native clipboard, PDF export and graceful failure messages.
4. Native .pcraft round-trip preserves page metadata, selected content and off-page object coordinates; regression tests cover invalid page ownership and undo/redo.
5. New beta test findings categorized blocker/known limitation. Blocker bugs fixed before release, never waived to meet a date.
6. No unexpected PhotoCraft update checks; branding and required attribution/licenses audited.
7. Signed-off release notes specify beta limitations, supported Windows architecture, dependencies and installation/uninstall method. Verify generated Windows executable and artifacts before publishing.

## Seven-day engineering focus (order, not automatic execution)

| Day | Focus | Acceptance evidence |
| --- | --- | --- |
| 1 | Freeze beta scope and audit current PR/CI; stop non-critical feature expansion | Written scope, blockers, and green baseline |
| 2 | Native save/reopen + off-page object and page membership regression coverage | Targeted tests |
| 3 | Windows UI shortcut, selection, and workspace regression fixes | Passing tests and GUI checklist |
| 4 | Multipage PDF smoke tests and known print limitations | Export validation and release note |
| 5 | Branding, opt-in updates, crash handling, and dependencies audit | Checklist and test results |
| 6 | Windows release compilation, application artifact inspection, manual smoke test | Beta-candidate build |
| 7 | Fix release blockers, re-run gating checks, publish only if all gates green | Go/no-go decision |

## Go/no-go

A pass means a **usable beta with disclosed limitations**, not full feature parity with CorelDRAW or a production-print application. If any critical GUI, data-loss, or installer issue remains, do not declare beta complete. Record the blocker and continue until validated.

No CI success alone constitutes manual GUI or installer validation.
