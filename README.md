# snip2me

snip2me is a browser-side code-to-image renderer. It takes source code from HTML `<pre>` blocks, tokenizes it with language-specific parsers, paints syntax-highlighted text on an HTML5 canvas, and replaces the original block with an image (data URL).

Project link (from project metadata/banner): http://snip2.me/

## Purpose

snip2me exists to make shareable code snippets that preserve visual styling regardless of external CSS, fonts, or hosting platform constraints. Instead of depending on runtime syntax-highlighting CSS, it produces a self-contained rendered image of code.

## What This Repository Contains

- A CoffeeScript implementation of a tokenization + painting pipeline.
- Language parsers for C#, Java, Ruby, and CoffeeScript.
- Color schemes (VS 2010 and Aptana).
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
- Ruby: `rb`, `ruby`
- CoffeeScript: `coffee`, `coffeescript`

You can inspect runtime availability using `snip2.parsers()`.

## Supported Schemes

Registered scheme codes:

- `vs2010`
- `aptana`

You can inspect runtime availability using `snip2.schemes()`.

## HTML Usage

Include the built script and annotate a `<pre>` element:

```html
<script src="dist/s2m.js"></script>

<pre
  data-snip-lang="cs"
  data-snip-scheme="vs2010"
  data-snip-painter-1="border => radius:5,width:1"
  data-snip-conf-min-width="800">
// your code here
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
   <pre data-snip-lang="ruby" data-snip-scheme="vs2010" data-snip-painter-1="border => radius:5,width:1">
def hello(name)
   puts "Hello, #{name}!"
end
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

### Global defaults

You can set a global config object before the script loads:

```html
<script>
  var snip = {
      minWidth: 400
  };
</script>
```

`minwidth` (lowercase `w`) is still accepted for backward compatibility with older embeds, but `minWidth` is the preferred key.

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

### Prerequisites

- Node.js
- npm

### Install dependencies

```bash
npm install
```

### Build

Default build runs:

1. CoffeeLint on `lib/*.coffee`
2. Remove `dist`
3. Compile CoffeeScript bundle to `dist/s2m.js`
4. Minify to `dist/s2m.min.js`

Run:

```bash
npm run build
```

You can also run Grunt directly (`npx grunt`). A `Gruntfile.js` alias is included for modern Grunt discovery.

## GitHub Actions

This repository includes two workflows:

- `.github/workflows/build.yml`
   - Runs on push/PR/manual trigger.
   - Builds `dist/s2m.js` and `dist/s2m.min.js`.
   - Uploads build outputs as artifact `snip2me-dist`.

- `.github/workflows/release.yml`
   - Runs on tags matching `v*` (for example `v0.2.0`) and manual trigger.
   - Builds the bundle.
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

- Build config updated from deprecated Grunt `min` usage to `uglify` plugin configuration.
- Added modern Grunt entrypoint (`Gruntfile.js`) while keeping existing `grunt.js` logic.
- Updated package metadata and dev dependencies for current Node tooling.
- Fixed runtime `compile(...)` context handling so programmatic usage without explicit context no longer fails due to scheme creation using a null context.

## License

MIT licensing by Oleksii Glib.

## About the Website Description

The repository metadata and banner reference http://snip2.me as the official project site.
This README purpose/description is based on direct source-code analysis in this repository and the project metadata references.