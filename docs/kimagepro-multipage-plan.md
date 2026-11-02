# KimagePro Multipage — Development specification

Status: **Early implementation, unmerged**. The built-in **Multipage** workspace is selectable. Page Up/Down insert artboard-backed pages before/after the active page (except during text editing); basic page controls show pages in the same top-to-bottom order used by PDF export. Ordered insertion, duplication, reordering, and undo have automated regression tests. The artboard backing is not yet a true multipage document model; off-page editing, paste in place, detailed page metadata, and complete save/reopen validation remain unfinished.

## Hard constraints
- No AI, model inference, external AI services, or AI-powered tools.
- Preserve the existing image-editing workspace and all Photoshop-style shortcuts outside Multipage.
- Do not merge into the release branch until Windows build, UI, document round-trip, and regression tests pass.
- Retain upstream license and asset attribution notices.

## Milestone 1: page model and pasteboard

Current progress: existing artboards are reused as initial page primitives. A basic Pages section offers selection, blank creation, duplication, deletion, visual geometry tiles, and reordering; reading order is derived from top-level layer order, including PDF export. True page identity/order metadata, content thumbnails, and page-independent placement have **not** been added.
- Persist ordered pages with stable IDs, page dimensions, margins, bleed, optional facing-page arrangement, and page-specific object associations.
- Provide an editable pasteboard beyond pages. Off-page objects remain visible, selectable, transformable, and saved with the document, but are excluded from PDF output unless intersecting the exported page or bleed.
- Test hit-testing and rendering at negative canvas coordinates; no destructive clipping when objects leave a page.
- Rendered content thumbnails, editable page names, and durable page-specific properties remain. Basic insertion before/after, geometry preview tiles, duplicate/delete/reorder, and page selection are present on the development branch.
- Distinguish page position (within page) from workspace placement (where each page appears on pasteboard).

## Keyboard behavior to verify with owner
The user describes Page Up/Down **creating** pages. Current provisional behavior: Page Down inserts after the current page; Page Up inserts before, in both page list and PDF export order. Only bare nonrepeating keys act in Multipage, and focused input or active text editing suppresses insertion. Other workspaces retain the original scrolling shortcuts. A separate navigation shortcut may be added.

## Milestone 2: object alignment and paste-in-place
- P centers selection on active page; L/R/T/B and E/C follow CorelDRAW conventions, scoped to Multipage only.
- Select an explicit alignment reference: page, selection, key object, margins or guides, as supported.
- Ctrl+C and Ctrl+V between KimagePro documents retain source page-relative physical X/Y positions, transformations, stacking order and relative spacing. Off-page coordinates remain valid.
- Define behavior for mixed resolution, different units, document size, multi-selection, text layers, and clipboard from other applications.
- In Image Editing mode, preserve existing normal paste and keyboard shortcuts.

## Milestone 3: output
- Multi-page PDF: ordered pages, correct media/crop/bleed boxes, page dimensions and compression. Preserve document editability in KimagePro's native source.
- Presentation templates, page numbering, master pages, imposition-ready options and data-driven catalog automation later.
- Batch exports and social-media presets can reuse document/export infrastructure.

## Other prioritized requirements
Existing tools should be audited before extending: healing/clone, dodge/burn, frequency separation, LUTs, smart filters, text, vector paths, guides, rulers, exports, actions, keyboard shortcuts, plugin system, auto-save/recovery, and GPU settings.
Actual scratch-disk tile spilling is not implemented merely by the current preferences; build a robust disk-backed cache as a separate milestone.

## Testing gate
- Existing image workspace behavior is unchanged.
- Switching to Multipage is available and does not silently alter an open image.
- Pages, pasteboard objects, and off-page position survive save/close/reopen.
- Shortcut dispatch respects text entry and active workspace.
- PDF pages have correct crop and bleed geometry.
- Windows build compiles with all tests passing.
