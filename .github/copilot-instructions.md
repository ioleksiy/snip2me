# Copilot Instructions for snip2me

## Project context

- This repository is a legacy CoffeeScript codebase for rendering syntax-highlighted code snippets to images.
- Main source is in `lib/`; generated bundles are in `dist/`; demo page is `test/index.html`.

## Documentation rule (mandatory)

When behavior, API, parsing support, painters/schemes, compatibility, or build workflow changes, update `README.md` in the same change set.

At minimum, sync README for changes to:

- Supported languages/parsers.
- Supported schemes/painters.
- Public API signatures and usage examples.
- Build/install process.
- Limitations, compatibility, or project status.

## Working style

- Preserve existing CoffeeScript style and architecture.
- Avoid unrelated refactors.
- Keep demo usage in `test/index.html` aligned when behavior changes.
