# KimagePro — Quality-first release plan

Status: **Active development; no fixed release deadline.**

This document supersedes the earlier seven-day beta target. The **13 November 2026 date is withdrawn**. The original goal is to build a stable, useful, integrated KimagePro editor rather than ship an incomplete application to meet an arbitrary schedule.

## Product priorities (in order)

1. **Independent multipage model and editable pasteboard.** Separate logical page order from artboard stacking, preserve stable object ownership and coordinates, make off-page artwork visible and editable, and validate saving/reopening, undo/redo, selection, hit-testing, and export.
2. **Integrated vector editing.** Develop one consistent object and tool model alongside raster editing: paths, nodes, transforms, shapes, text, stacking, selection, and non-destructive operations. Avoid launching a second disconnected vector application.
3. **PowerClip-style containers.** Support closed-path clipping, editable contents and container boundary, undoable placement/extraction, nesting safeguards, document persistence, and correct export.
4. **Professional multipage print/PDF.** Implement correct page/trim/bleed/crop geometry, page-order output, page ownership rules, and reliable export from both raster and vector content.
5. **Quality, performance, and Windows release.** Validate existing raster functionality, compatibility, crash recovery, large documents, branding, update opt-in, licensing and attribution. Complete GUI acceptance testing before release.

## Non-negotiable stability gates

- Rustfmt, Clippy, Linux CI, corpus tests, Windows unit and integration matrices, and Web/WASM checks must pass for release candidates.
- Test the behavior users experience, not only command-layer unit tests: Windows GUI startup, tool switching, canvas interactions, undo/redo, native document round-trip, clipboard, off-page editing, and PDF output.
- Preserve existing raster/image-editing shortcuts and behavior outside Multipage.
- Retain upstream license and attribution notices. KimagePro automatic update checking stays **off by default**, with explicit user opt-in.
- Do **not** build Windows installers repeatedly for every feature edit. Run the Windows test matrix as needed and produce a final release candidate build only after development gates are satisfied.
- Do not merge draft PR #3 or label any build release-ready with unresolved data-loss, rendering, workflow, or installation blockers.
- Document limitations honestly. Automated Windows CI is not equivalent to hands-on Windows GUI testing.

## Development checkpoints

| Checkpoint | Completion evidence |
| --- | --- |
| Multipage and pasteboard | Correct rendering, hit-testing, ownership, editing and save/reopen regression coverage |
| Vector integration | Unified tool and object workflows with mixed raster/vector documents |
| PowerClip | Nested clipping, edit/extract, undo/redo, persistence and export tests |
| PDF/print | Correct page geometry and content verified against sample multi-page projects |
| Stabilization | Linux/Windows green, manual Windows GUI verification and resolved critical bugs |
| Release | Verified Windows artifact, documentation, release notes and explicit go/no-go review |

## Timing

The earlier engineering-effort estimate (roughly **8–15 engineer-months** for the full feature scope) is a planning range, not a delivery promise. Calendar time depends on integration complexity, staffing, discoveries and the amount of hands-on validation needed. Do not make time-based commitments without the evidence required for a reliable schedule.

A beta may be offered before the full release if it is independently useful and clearly labeled, but **feature completion and stability**, not the calendar, determine readiness.
