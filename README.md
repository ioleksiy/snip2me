# snip2.me Website (Static One-Pager)

This repository contains the static one-page website for [snip2me](http://snip2.me/).

It is not the library source repository. Instead, this page demonstrates the `snip2me` browser library in action and provides end-user documentation for embedding rendered code snippets.

## What This Project Is

- A static marketing/demo page (`index.html`) for snip2me.
- A live playground where users can paste code and preview image output.
- A documentation surface for embed usage and configuration attributes.

## Library Injection

The page injects the snip2me bundle from GitHub Releases.

Current pinned tag:

- `v0.2.0`

Script source used on this page:

```html
<script src="https://github.com/ioleksiy/snip2me/releases/download/v0.2.0/s2m.min.js"></script>
```

## Usage Style Demonstrated

The one-pager demonstrates the current attribute-based usage:

- Add `data-snip-lang` and `data-snip-scheme` to `<pre>`.
- Optionally add painter chain attributes like `data-snip-painter-1`.
- Optionally add per-block settings with `data-snip-conf-*`.

Example:

```html
<pre
  data-snip-lang="ruby"
  data-snip-scheme="vs2010"
  data-snip-painter-1="border => radius:5,width:1"
  data-snip-conf-min-width="640"
>
def hello(name)
  puts "Hello, #{name}!"
end
</pre>
```

On page load, snip2me scans matching `<pre>` blocks and replaces them with rendered snippet images.

## Relationship to Main Library Repo

Library source, release automation, and full API documentation live in:

- `https://github.com/ioleksiy/snip2me`

This static page should stay aligned with the latest stable release usage documented there.
