const fs = require('fs');
const path = require('path');
const vm = require('vm');

function makeCanvasContext() {
  return {
    textBaseline: 'top',
    textAlign: 'left',
    font: 'normal 12px Courier New',
    fillStyle: '#000000',
    strokeStyle: '#000000',
    lineWidth: 1,
    beginPath() {},
    moveTo() {},
    lineTo() {},
    quadraticCurveTo() {},
    closePath() {},
    stroke() {},
    fill() {},
    fillText() {},
    measureText(text) {
      const width = String(text || '').length * 7;
      return { width };
    }
  };
}

function makeElement(tag) {
  if (tag === 'canvas') {
    return {
      width: 0,
      height: 0,
      getContext() {
        return makeCanvasContext();
      },
      toDataURL() {
        return 'data:image/png;base64,AA==';
      }
    };
  }
  if (tag === 'img') {
    return { src: '' };
  }
  return {};
}

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

const bundlePath = path.resolve(__dirname, '../dist/s2m.js');
const code = fs.readFileSync(bundlePath, 'utf8');
vm.runInThisContext(code, { filename: bundlePath });

if (!global.snip2) {
  throw new Error('Smoke test failed: window.snip2/global snip2 is missing');
}

const parsers = global.snip2.parsers();
if (!Array.isArray(parsers) || parsers.length === 0) {
  throw new Error('Smoke test failed: snip2.parsers() returned no parsers');
}

const schemes = global.snip2.schemes();
if (!Array.isArray(schemes) || schemes.length === 0) {
  throw new Error('Smoke test failed: snip2.schemes() returned no schemes');
}

const uri = global.snip2.compile(
  'ruby',
  "def hello(name)\n  puts name\nend\n",
  'vs2010',
  [],
  { minWidth: 0, font: 'Courier New', size: 12 }
);

if (typeof uri !== 'string' || uri.indexOf('data:image/') !== 0) {
  throw new Error('Smoke test failed: snip2.compile(...) did not return a data URI');
}

console.log('Smoke test passed: snip2 global and basic API are functional.');
