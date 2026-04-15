const fs = require('fs');
const path = require('path');
const vm = require('vm');
const { createCanvas } = require('@napi-rs/canvas');

const PNG_SIGNATURE = [0x89, 0x50, 0x4e, 0x47, 0x0d, 0x0a, 0x1a, 0x0a];

function assert(condition, message) {
  if (!condition) {
    throw new Error(message);
  }
}

function hasPngSignature(buffer) {
  if (!Buffer.isBuffer(buffer) || buffer.length < PNG_SIGNATURE.length) {
    return false;
  }
  for (let i = 0; i < PNG_SIGNATURE.length; i += 1) {
    if (buffer[i] !== PNG_SIGNATURE[i]) {
      return false;
    }
  }
  return true;
}

function readPngDimensions(buffer) {
  assert(hasPngSignature(buffer), 'Self-test failed: PNG signature is invalid.');
  const width = buffer.readUInt32BE(16);
  const height = buffer.readUInt32BE(20);
  return { width, height };
}

function makeElement(tag) {
  if (tag === 'canvas') {
    return createCanvas(1, 1);
  }
  if (tag === 'img') {
    let src = '';
    return {
      get src() {
        return src;
      },
      set src(value) {
        src = String(value);
      }
    };
  }
  return {};
}

function bootstrapBrowserLikeGlobals() {
  global.window = {
    addEventListener() {},
    attachEvent() {}
  };

  global.navigator = {
    appName: 'Netscape',
    appVersion: '22.0',
    userAgent: 'Mozilla/5.0 Chrome/122.0.0.0 Safari/537.36'
  };

  global.document = {
    createElement: makeElement,
    getElementById() {
      return null;
    },
    getElementsByTagName() {
      return [];
    }
  };
}

function loadBundle() {
  const bundlePath = path.resolve(__dirname, '../dist/s2m.js');
  if (!fs.existsSync(bundlePath)) {
    throw new Error('Self-test failed: missing dist/s2m.js (run `npm run build` first).');
  }
  const code = fs.readFileSync(bundlePath, 'utf8');
  vm.runInThisContext(code, { filename: bundlePath });
}

function getBase64Payload(uri) {
  const marker = 'base64,';
  const idx = uri.indexOf(marker);
  assert(idx !== -1, 'Self-test failed: rendered data URI is missing base64 payload.');
  return uri.substring(idx + marker.length);
}

function makePreElement(attrs, text) {
  const attributes = Object.keys(attrs).map((name) => ({ name, value: attrs[name] }));
  return {
    nodeType: 1,
    nodeName: 'PRE',
    attributes,
    childNodes: [{ nodeValue: text }],
    getAttribute(name) {
      return Object.prototype.hasOwnProperty.call(attrs, name) ? attrs[name] : null;
    }
  };
}

function run() {
  bootstrapBrowserLikeGlobals();
  loadBundle();

  assert(global.snip2, 'Self-test failed: window.snip2/global snip2 is missing.');

  const parsers = global.snip2.parsers();
  assert(Array.isArray(parsers) && parsers.length > 0, 'Self-test failed: snip2.parsers() returned no parsers.');

  const schemes = global.snip2.schemes();
  assert(Array.isArray(schemes) && schemes.length > 0, 'Self-test failed: snip2.schemes() returned no schemes.');

  const tempBase = path.resolve(__dirname, '../tmp');
  fs.mkdirSync(tempBase, { recursive: true });
  const tempRoot = fs.mkdtempSync(path.join(tempBase, 'selftest-'));
  const keepTemp = process.env.SNIP2ME_KEEP_SELFTEST_TMP === '1';
  const generated = [];

  try {
    const cases = [
      {
        name: 'ruby-vs2010',
        ext: 'ruby',
        scheme: 'vs2010',
        text: 'def hello(name)\n  puts name\nend\n'
      },
      {
        name: 'java-aptana',
        ext: 'java',
        scheme: 'aptana',
        text: 'class App {\n  static void main(String[] a) {}\n}\n'
      },
      {
        name: 'coffee-vs2010',
        ext: 'coffee',
        scheme: 'vs2010',
        text: 'sum = (a, b) -> a + b\nconsole.log sum(2, 3)\n'
      },
      {
        name: 'js-one-dark',
        ext: 'js',
        scheme: 'one-dark',
        text: 'const sum = (a, b) => a + b;\nconsole.log(sum(2, 3));\n'
      },
      {
        name: 'python-github-light',
        ext: 'python',
        scheme: 'github-light',
        text: 'def add(a, b):\n    return a + b\nprint(add(2, 3))\n'
      },
      {
        name: 'json-monokai',
        ext: 'json',
        scheme: 'monokai',
        text: '{\n  "name": "snip2me",\n  "ok": true\n}\n'
      },
      {
        name: 'cpp-solarized-dark',
        ext: 'cpp',
        scheme: 'solarized-dark',
        text: '#include <iostream>\nint main() { std::cout << "hi"; }\n'
      },
      {
        name: 'bash-solarized-light',
        ext: 'bash',
        scheme: 'solarized-light',
        text: '#!/usr/bin/env bash\nfor f in a b; do echo "$f"; done\n'
      },
      {
        name: 'rust-dracula',
        ext: 'rs',
        scheme: 'dracula',
        text: 'fn main() {\n  println!("hi");\n}\n'
      },
      {
        name: 'sql-dracula',
        ext: 'sql',
        scheme: 'dracula',
        text: 'SELECT id, name\nFROM users\nWHERE active = true\nORDER BY id;\n'
      },
      {
        name: 'kotlin-nord',
        ext: 'kotlin',
        scheme: 'nord',
        text: 'fun sum(a: Int, b: Int): Int {\n  return a + b\n}\n'
      },
      {
        name: 'swift-xcode-light',
        ext: 'swift',
        scheme: 'xcode-light',
        text: 'func greet(name: String) {\n  print("Hello, \\(name)")\n}\n'
      },
      {
        name: 'php-intellij-light',
        ext: 'php',
        scheme: 'intellij-light',
        text: '<?php\nfunction add($a, $b) {\n  return $a + $b;\n}\n'
      },
      {
        name: 'html-nord',
        ext: 'html',
        scheme: 'nord',
        text: '<html>\n  <body>\n    <h1>Hello</h1>\n  </body>\n</html>\n'
      },
      {
        name: 'css-xcode-light',
        ext: 'css',
        scheme: 'xcode-light',
        text: '.card {\n  color: #222;\n  padding: 8px;\n}\n'
      },
      {
        name: 'xml-intellij-light',
        ext: 'xml',
        scheme: 'intellij-light',
        text: '<?xml version="1.0"?>\n<root>\n  <item id="1"/>\n</root>\n'
      }
    ];

    for (const item of cases) {
      const uri = global.snip2.compile(
        item.ext,
        item.text,
        item.scheme,
        [],
        { minWidth: 100, font: 'Courier New', size: 14, pixelRatio: 2 }
      );

      assert(typeof uri === 'string' && uri.indexOf('data:image/') === 0,
        `Self-test failed: compile did not return a data URI for ${item.name}.`);

      const buffer = Buffer.from(getBase64Payload(uri), 'base64');
      assert(hasPngSignature(buffer), `Self-test failed: output is not a PNG for ${item.name}.`);
      const dim = readPngDimensions(buffer);
      assert(dim.width >= 200, `Self-test failed: output width is too small for ${item.name} (${dim.width}px).`);
      assert(dim.height >= 40, `Self-test failed: output height is too small for ${item.name} (${dim.height}px).`);

      const outputFile = path.join(tempRoot, `${item.name}.png`);
      fs.writeFileSync(outputFile, buffer);
      assert(fs.existsSync(outputFile), `Self-test failed: missing output file ${outputFile}.`);
      assert(fs.statSync(outputFile).size > 0, `Self-test failed: output file is empty ${outputFile}.`);
      generated.push(outputFile);
      console.log(`Generated ${item.name}: ${dim.width}x${dim.height}`);
    }

    let replacedNode = null;
    let replacedWith = null;
    const pre = makePreElement(
      {
        'data-snip-lang': 'ruby',
        'data-snip-scheme': 'vs2010',
        'data-snip-conf-min-width': '0',
        'data-snip-conf-pixel-ratio': '2',
        'data-snip-painter-1': 'border => radius:5,width:1'
      },
      'puts "hello"\n'
    );
    pre.parentNode = {
      replaceChild(newNode, oldNode) {
        replacedWith = newNode;
        replacedNode = oldNode;
      }
    };

    const transformed = global.snip2.compile(pre);
    assert(transformed === true, 'Self-test failed: element-based compile did not return true.');
    assert(replacedNode === pre, 'Self-test failed: element-based compile did not replace the expected node.');
    assert(replacedWith && typeof replacedWith.src === 'string' && replacedWith.src.indexOf('data:image/') === 0,
      'Self-test failed: replacement image src is not a data URI.');

    console.log('Self-test passed in headless mode.');
    console.log(`Generated ${generated.length} temporary PNG file(s) in ${tempRoot}`);

    if (!keepTemp) {
      fs.rmSync(tempRoot, { recursive: true, force: true });
      console.log('Temporary output removed. Set SNIP2ME_KEEP_SELFTEST_TMP=1 to keep generated files.');
    } else {
      console.log('Temporary output kept (SNIP2ME_KEEP_SELFTEST_TMP=1).');
    }
  } catch (err) {
    if (!keepTemp) {
      fs.rmSync(tempRoot, { recursive: true, force: true });
    }
    throw err;
  }
}

run();
