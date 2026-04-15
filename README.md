# snip2me

snip2me is a browser-side code-to-image renderer. It takes source code from HTML `<pre>` blocks, tokenizes it with language-specific parsers, paints syntax-highlighted text on an HTML5 canvas, and replaces the original block with an image (data URL).

Project link (from project metadata/banner): http://snip2.me/

## Purpose

snip2me exists to make shareable code snippets that preserve visual styling regardless of external CSS, fonts, or hosting platform constraints. Instead of depending on runtime syntax-highlighting CSS, it produces a self-contained rendered image of code.

## What This Repository Contains

- A CoffeeScript implementation of a tokenization + painting pipeline.
- Language parsers for C#, Java, JavaScript, TypeScript, Python, Go, C, C++, Rust, Bash, SQL, Kotlin, Swift, PHP, HTML, CSS, XML, JSON, YAML, Ruby, and CoffeeScript.
- Color schemes (VS 2010, Aptana, GitHub Light, GitHub Dark, Monokai, One Dark, Solarized Light, Solarized Dark, Dracula, IntelliJ Light, Nord, and Xcode Light).
- Painter decorators (currently a border painter) that can wrap the code painter.
- A demo page in `test/index.html` that shows attribute-based usage.
- A legacy Grunt build that compiles `lib/*.coffee` into `dist/s2m.js` and minifies to `dist/s2m.min.js`.

## High-Level Architecture

The pipeline is organized into clear stages:

1. Input discovery:
   - On page load, `snip2` scans for elements with `data-snip-lang`.
2. Parsing:
   - `ParserFactory` picks a parser by extension/language code.
   - A `SyntaxParser` runs analyzers (newline, spaces, comments, delimiters, strings, etc.) and produces typed tokens.
3. Styling:
   - `SchemeFactory` builds a color/font scheme.
4. Rendering:
   - `CodePainter` draws token text to canvas.
   - Optional decorators from `PainterFactory` (for example `border`) wrap around the base painter.
5. Output:
   - Canvas is exported via `toDataURL()` and inserted as an `<img>` replacing the original `<pre>`.

## Supported Languages

Registered parser codes:

- C#: `cs`, `csharp`, `c#`
- Java: `java`
- JavaScript: `js`, `javascript`, `mjs`, `cjs`
- TypeScript: `ts`, `typescript`, `tsx`
- Python: `py`, `python`
- Go: `go`, `golang`
- C: `c`, `h`
- C++: `cpp`, `cxx`, `cc`, `hpp`, `hh`
- Rust: `rs`, `rust`
- Bash: `sh`, `bash`, `zsh`
- SQL: `sql`
- Kotlin: `kt`, `kts`, `kotlin`
- Swift: `swift`
- PHP: `php`, `phtml`
- HTML: `html`, `htm`, `xhtml`
- CSS: `css`, `scss`, `less`
- XML: `xml`, `xsd`, `svg`
- JSON: `json`
- YAML: `yaml`, `yml`
- Ruby: `rb`, `ruby`
- CoffeeScript: `coffee`, `coffeescript`

You can inspect runtime availability using `snip2.parsers()`.

## Supported Schemes

Registered scheme codes:

- `vs2010`
- `aptana`
- `github-light`
- `github-dark`
- `monokai`
- `one-dark`
- `solarized-light`
- `solarized-dark`
- `dracula`
- `intellij-light`
- `nord`
- `xcode-light`

You can inspect runtime availability using `snip2.schemes()`.

## HTML Usage

Include the built script and annotate a `<pre>` element:

```html
<script src="dist/s2m.js"></script>

<pre
   data-snip-lang="swift"
   data-snip-scheme="xcode-light"
  data-snip-painter-1="border => radius:5,width:1"
  data-snip-conf-min-width="800">
func greet(name: String) {
    print("Hello, \(name)")
}
</pre>
```

## Install on Third-Party Websites

You can consume snip2me without cloning this repository.

### Option 1: Use GitHub Releases (recommended)

1. Open the latest release assets:
    - `https://github.com/ioleksiy/snip2me/releases/latest`
2. Use the direct script URL in your page:

```html
<script src="https://github.com/ioleksiy/snip2me/releases/latest/download/s2m.min.js"></script>
```

3. Add `data-snip-*` attributes to your `<pre>` blocks (example below).

### Option 2: Download and self-host

1. Download `s2m.js` or `s2m.min.js` from a release.
2. Place the file on your own CDN/static host.
3. Include it via your own URL:

```html
<script src="https://your-cdn.example.com/js/s2m.min.js"></script>
```

### Minimal page example

```html
<!doctype html>
<html>
<head>
   <meta charset="utf-8" />
   <script src="https://github.com/ioleksiy/snip2me/releases/latest/download/s2m.min.js"></script>
</head>
<body>
   <pre data-snip-lang="kotlin" data-snip-scheme="nord" data-snip-painter-1="border => radius:5,width:1">
fun sum(a: Int, b: Int): Int {
   return a + b
}
   </pre>
</body>
</html>
```

On page load, snip2me automatically transforms matching `<pre>` blocks into rendered snippet images.

### Supported element attributes

- `data-snip-lang`: language code used to pick parser.
- `data-snip-scheme`: visual scheme code.
- `data-snip-painter-N`: painter chain items, sorted by N.
- `data-snip-conf-*`: per-element settings (example: `data-snip-conf-min-width`).
- `data-snip-conf-pixel-ratio`: render scale multiplier (for example `2` for higher-resolution output).

### Global defaults

You can set a global config object before the script loads:

```html
<script>
  var snip = {
         minWidth: 400,
         pixelRatio: 2
  };
</script>
```

`minwidth` (lowercase `w`) is still accepted for backward compatibility with older embeds, but `minWidth` is the preferred key.

By default, snip2me now renders with `pixelRatio: 2` for higher-quality output on modern HiDPI displays. Set `pixelRatio: 1` if you need legacy-size output.

## Programmatic API

Public methods on global `snip2`:

- `snip2.compile(elementOrArgs)`
- `snip2.setSettings(settings)`
- `snip2.parsers()`
- `snip2.schemes()`

`compile` supports either:

- Passing a DOM element (`<pre>`) to transform in-place, or
- Calling the lower-level transform signature:
  `compile(ext, text, scheme, painters, context)`.

## Build and Development

This project keeps its legacy CoffeeScript + Grunt architecture, with a compatibility refresh so it runs on modern Node/Grunt.

Note: build uses the modern `coffeescript` compiler package while preserving legacy runtime behavior through deterministic source ordering and smoke-test validation.

### Prerequisites

- Node.js >= 22
- npm >= 10

### Install dependencies

```bash
npm install
```

### Build

Default build runs:

1. CoffeeLint on `lib/*.coffee`
2. Remove `dist`
3. Compile CoffeeScript bundle to `dist/s2m.js` using an explicit dependency-safe source order
4. Minify to `dist/s2m.min.js` with `terser`

The bundle compile step concatenates ordered sources with explicit newline separators, then runs `coffee --compile --stdio` (replacement for deprecated `coffee --join`).

Run:

```bash
npm run build
```

### Headless self-test

A runtime self-test validates that the generated bundle initializes correctly in a headless Node environment and can generate temporary output files on disk:

```bash
npm run selftest
```

Backward-compatible alias:

```bash
npm run smoke
```

The self-test checks:

- `snip2` global exists after bundle load.
- `snip2.parsers()` and `snip2.schemes()` return populated arrays.
- `snip2.compile(...)` returns PNG data URIs for multiple language/scheme combinations.
- Decoded PNG payloads are written as temporary files on disk and validated.
- Element-based `compile(element)` replaces a `<pre>` node with an `<img>` node.
- PNG dimensions are validated to ensure higher-resolution output.

The self-test uses a headless canvas backend (`@napi-rs/canvas`) so the generated PNG files are real rendered snippet images.

Self-test artifacts are generated under `tmp/selftest-*` inside the project directory. The `tmp/` folder is created automatically by the self-test and is git-ignored. By default, the generated run folder is removed automatically after success/failure. Set `SNIP2ME_KEEP_SELFTEST_TMP=1` to keep generated files for inspection.

You can also run Grunt directly (`npx grunt`). A `Gruntfile.js` alias is included for modern Grunt discovery.

## GitHub Actions

This repository includes two workflows:

- `.github/workflows/build.yml`
   - Runs on push/PR/manual trigger.
   - Builds `dist/s2m.js` and `dist/s2m.min.js`.
   - Runs `npm run selftest` to verify headless initialization and output generation.
   - Uploads build outputs as artifact `snip2me-dist`.

- `.github/workflows/release.yml`
   - Runs on tags matching `v*` (for example `v0.2.0`) and manual trigger.
   - Builds the bundle.
   - Runs `npm run selftest` before publishing artifacts.
   - Creates/updates a GitHub Release and uploads `s2m.js` and `s2m.min.js` as release assets.

### Creating a release build

```bash
git tag v0.2.0
git push origin v0.2.0
```

After the workflow completes, third-party sites can use:

```html
<script src="https://github.com/ioleksiy/snip2me/releases/latest/download/s2m.min.js"></script>
```

## Current Limitations / Notes

- `transformGist` exists but is not implemented.
- Browser compatibility checks target older browser generations and may need modernizing.
- This is still a legacy-style codebase (CoffeeScript + old parser/painter design), maintained for compatibility.

## Compatibility Fixes Applied

- Build config updated from deprecated Grunt `min` usage to a deterministic shell-based `terser` minification step.
- Added modern Grunt entrypoint (`Gruntfile.js`) while keeping existing `grunt.js` logic.
- Updated package metadata and dev dependencies for current Node tooling.
- Fixed runtime `compile(...)` context handling so programmatic usage without explicit context no longer fails due to scheme creation using a null context.
- Fixed a release-blocking bundling-order bug by replacing implicit directory concatenation with an explicit dependency-safe source order (prevents subclasses from being emitted before base classes).
- Added a runtime headless self-test (`test/selftest.js`, with `test/smoke.js` alias) and enforced it in CI/release workflows.
- Enabled high-DPI rendering by default via `pixelRatio: 2` (configurable) to improve output quality on modern displays.

## License

MIT licensing by Oleksii Glib.

## About the Website Description

The repository metadata and banner reference http://snip2.me as the official project site.
This README purpose/description is based on direct source-code analysis in this repository and the project metadata references.