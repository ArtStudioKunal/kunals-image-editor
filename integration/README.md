# VectorCraft integration preview

This branch introduces an **experimental Windows bundle** that packages the existing PhotoCraft-based `KunalsImageEditor.exe` and upstream VectorCraft as `VectorEditor.exe` with one `KunalsCreativeSuite.cmd` launcher.

The launcher lets you choose between the two separate applications. **This is not yet a single integrated editing canvas or a merged document model.** Files are exchanged through ordinary exports/imports, not live shared layers or unified undo.

## Build

Run the GitHub Actions workflow **Build Kunal's Image & Vector Suite (Windows)** on the `feature/vectorcraft-integration` branch. Download the `Kunals-Creative-Suite-Windows-x64` artifact after a successful build. Extract everything together, and double-click `KunalsCreativeSuite.cmd`.

The workflow checks out the current VectorCraft `main` branch at build time. For reproducible releases, pin its commit before publishing a final release. Retain the included license and attribution files.

## Next integration stage

A true single-window editor requires choosing a shared document model, implementing conversions between vector objects and raster layers, integrating VectorCraft tools and panels, and carefully reconciling dependencies and keyboard shortcuts. Those features are not included in this preview.
