# Project Instructions (Maintenance Notes)

This file explains the repository at a practical level and defines update rules for future changes.

## What Is Here

- `lib/`: CoffeeScript source code for parser, tokenizer analyzers, schemes, painters, and wrapper API.
- `dist/`: generated JavaScript bundles (`s2m.js`, `s2m.min.js`).
- `test/index.html`: demo usage for rendering `<pre>` blocks into images.
- `grunt.js`: legacy build pipeline (lint, compile, minify).
- `package.json`: minimal project metadata and dependencies.

## Core Behavior Summary

- The runtime scans DOM for `data-snip-lang`.
- It tokenizes source text via parser factories.
- It paints tokens on a canvas using selected scheme/painters.
- It replaces source blocks with rendered images.

## Mandatory Documentation Rule

For every meaningful code or behavior change, update `README.md` in the same change set.

At minimum, reflect updates in README when changing:

- Supported languages/parsers.
- Supported schemes/painters.
- Public API signatures or usage examples.
- Build/install process.
- Compatibility, limitations, or project status.

## Recommended Process for Future Contributors

1. Implement code change.
2. Verify demo/build flow still works.
3. Update README to match new behavior.
4. If applicable, update demo in `test/index.html` so usage examples stay accurate.
