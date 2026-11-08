# KimagePro Multipage — Development specification

Status: **Early implementation, unmerged**. The built-in **Multipage** workspace is selectable. Page Up/Down insert artboard-backed pages before/after the active page (except during text editing); basic page controls show pages in the same top-to-bottom order used by PDF export. Ordered insertion, duplication, reordering, and undo have automated regression tests. The artboard backing is not yet a true multipage document model; off-page editing, paste in place, detailed page metadata, and complete save/reopen validation remain unfinished.

## Hard constraints
- No AI, model inference, external AI services, or AI-powered tools.
- Preserve the existing image-editing workspace and all Photoshop-style shortcuts outside Multipage.
- Do not merge into the release branch until Windows build, UI, document round-trip, and regression tests pass.
- Retain upstream license and asset attribution notices.

## Milestone 1: page model and pasteboard

Current progress: existing artboards are reused as initial page primitives. A basic Pages section offers selection, blank creation, duplication, deletion, visual geometry tiles, reordering, naming, rotation and DPI-aware physical page presets. Pages now optionally carry native, undoable per-page margins and bleed metadata in document pixels; this is preserved by .pcraft serialization and inherited by page duplication. Reading order is still derived from top-level layer order, including PDF export. A fully independent multipage object model, rendered content thumbnails, editable pasteboard and print-box export remain **unfinished**.
- **Partial:** Ordered pages use stable layer IDs, persistent artboard dimensions and native per-page margin/bleed metadata (`multipage.page.setLayout`); .pcraft round-trip and undo are covered. The read-only `multipage.page.list` command now exposes page IDs, PDF reading order, workspace rectangles, insets, owned loose layers, unassigned pasteboard layers, and a workspace bounding rectangle including visible off-canvas root raster tiles. This supports future pan/zoom and rendering without changing export bounds. Fully separate page IDs/order from artboard stacking, optional facing-page arrangements, and full off-page editing still need dedicated support.
- **In progress:** loose top-level objects can be associated with a page or left unassigned on the pasteboard without moving. The Layers panel now assigns or detaches multiple selected loose objects atomically in one undo step; invalid mixed selections are rejected before changes. Full off-page canvas interaction and page/bleed-aware export are unfinished. Off-page objects should remain visible, selectable, transformable, and saved with the document, but be excluded from PDF output unless intersecting the exported page or bleed.
- Test hit-testing and rendering at negative canvas coordinates; no destructive clipping when objects leave a page.
- Rendered content thumbnails, durable margins/bleed metadata, and independent page positioning remain. Basic insertion before/after, geometry preview tiles, duplicate/delete/reorder, page selection, rename actions, rotate controls, and print-DPI-sized A4/A3/US Letter presets are present on the development branch.
- Distinguish page position (within page) from workspace placement (where each page appears on pasteboard).

## Keyboard behavior to verify with owner
The user describes Page Up/Down **creating** pages. Current provisional behavior: Page Down inserts after the current page; Page Up inserts before, in both page list and PDF export order. Only bare nonrepeating keys act in Multipage, and focused input or active text editing suppresses insertion. Other workspaces retain the original scrolling shortcuts. A separate navigation shortcut may be added.

## Milestone 2: object alignment and paste-in-place
- **Implemented on development branch (pending CI and Windows GUI verification):** P centers the combined selection on its owning Multipage page without collapsing object spacing. L/R/T/B and E/C follow CorelDRAW alignment conventions scoped to Multipage only. The P shortcut requires page membership; cross-page selections are rejected.
- Select an explicit alignment reference: page, selection, key object, margins or guides, as supported.
- **In progress:** In Multipage, Ctrl+C copies complete native selected layers (single raster layers included, with off-page raster tiles) and Ctrl+V pastes at the original document X/Y position between KimagePro documents. Normal image-editing Paste and external clipboard Paste are unchanged. Regression tests cover off-page native save/reopen and selection-aware copy. Page-relative unit conversions, all vector transforms, and mixed-resolution behavior still require validation.
- Define behavior for mixed resolution, different units, document size, multi-selection, text layers, and clipboard from other applications.
- In Image Editing mode, preserve existing normal paste and keyboard shortcuts.

## Milestone 3: output
- Multi-page PDF: ordered pages and basic physical MediaBox dimensions exist, but correct CropBox/BleedBox/TrimBox and print-content behavior are **not** yet implemented. The new native bleed/margin values do not alter PDF export until this milestone is implemented. Preserve editability in KimagePro's native source.
- Presentation templates, page numbering, master pages, imposition-ready options and data-driven catalog automation later.
- Batch exports and social-media presets can reuse document/export infrastructure.

## Milestone 4: PowerClip-style object containers (new requirement)

Status: **Planned; not implemented.** Add an integrated, non-destructive PowerClip-equivalent to KimagePro's Multipage/vector workflow, without depending on VectorCraft as a second application.

- **Container:** any supported closed vector path or shape can serve as the clipping boundary. Keep its own editable geometry, fill/stroke, transform, and stable identity separate from its contents. An open path must not silently clip.
- **Place inside:** an undoable "Place Inside Container" action inserts one or more existing selected raster, vector, or text objects into a specified container without flattening or rasterizing their original editable representation. Preserve stacking order and transforms.
- **Clipping/render:** content is visible only inside the container's filled vector boundary; content extending outside remains stored, movable, and editable. Ensure accurate canvas/GPU rendering and consistent export/print rasterization, including holes and anti-aliased edges.
- **Edit contents:** enter/exit an isolated container-editing mode to move, scale, rotate, replace and reorder contained objects. Also support editing the container outline independently, and an undoable "Extract Contents" command that restores original editable objects.
- **Nesting and safety:** support nested containers with a defined maximum depth or cycle detection; prohibit parenting a container into itself or any descendant. Reject invalid targets and locked content without partial mutations.
- **Page/pasteboard behavior:** page association, clipboard copy/paste, duplication, save/reopen, object alignment, guides, hit-testing, masks and page/PDF export must preserve the container hierarchy and original coordinates.
- **Keyboard/UI:** expose Place Inside, Edit Contents, Finish Editing and Extract Contents in the Layers/context UI. Keep existing CorelDRAW-style alignment letters and native image-editing shortcuts unchanged; any PowerClip shortcut must be explicitly assigned and customizable after conflict checks.
- **Validation:** add command, undo/redo, serialization/backward-compatibility, nested clipping, complex paths/holes, mixed raster/vector/text, copy/paste, off-page rendering, preview, PDF/PNG export, and Windows GUI regression tests. Gate merging on visible editor parity and no AI features.

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
