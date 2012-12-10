var observe;
if (window.attachEvent) {
    observe = function (element, event, handler) {
        element.attachEvent('on'+event, handler);
    };
}
else {
    observe = function (element, event, handler) {
        element.addEventListener(event, handler, false);
    };
}

function fillUl(id, a, selected, click, onSelect) {
	var buttons = document.getElementById(id).getElementsByTagName("ul")[0];
	while (buttons.hasChildNodes()) {
		buttons.removeChild(buttons.lastChild);
	}
	var i = 1;
	for (v in a) {
		var k = a[v];
		var li = document.createElement("li");
		if (i % 3 == 0) {
			li.className = 'thirdLi';
		}
		var b = document.createElement("button");
		if (k['code'] == selected) {
			b.className = 'selected';
			onSelect(b);
			selectedLang = b;
		}
		b.setAttribute('data-item', k['code']);
		b.innerHTML = k['name'];
		li.appendChild(b);
		buttons.appendChild(li);
		observe(b, 'click', click);
		i++;
	}
}

function init () {
    var text = document.getElementById('inputCode');
    function resize () {
        text.style.height = 'auto';
        text.style.height = text.scrollHeight+'px';
        text.className = (text.value == '') ? 'codeHere' : 'hCode';
        repaint();
    }
    function delayedResize () {
        window.setTimeout(resize, 0);
    }
    observe(text, 'change',  resize);
    observe(text, 'cut',     delayedResize);
    observe(text, 'paste',   delayedResize);
    observe(text, 'drop',    delayedResize);
    observe(text, 'keydown', delayedResize);

    text.focus();
    text.select();
    resize();
    
    fillUl('buttonsLanguage', snip2.parsers(), opts.lang, langClick, function (b) {selectedLang = b;});
    fillUl('buttonsScheme', snip2.schemes(), opts.scheme, schemeClick, function (b) {selectedScheme = b;});

	buttons = document.getElementById('sizes');
	while (buttons.hasChildNodes()) {
		buttons.removeChild(buttons.lastChild);
	}
	for(var i = 8; i < 30; i += 2) {
		var li = document.createElement("li");
		li.setAttribute('data-item', i);
		li.innerHTML = i + ' px';
		buttons.appendChild(li);
		observe(li, 'click', optLiClick);
		if (i == opts.size) {
			optLiClick.apply(li);
		}
	}
	
	buttons = document.getElementById('fonts');
	while (buttons.hasChildNodes()) {
		buttons.removeChild(buttons.lastChild);
	}
	for(var font in fonts) {
		var li = document.createElement("li");
		li.setAttribute('data-item', fonts[font]);
		li.innerHTML = fonts[font];
		buttons.appendChild(li);
		observe(li, 'click', optLiFontClick);
		if (fonts[font] == opts.font) {
			optLiFontClick.apply(li);
		}
	}
}

function langClick() {
	if (selectedLang != null) {
		selectedLang.className = '';
	}
	selectedLang = this;
	this.className = 'selected';
	opts.lang = this.getAttribute('data-item');
	repaint();
}

function schemeClick() {
	if (selectedScheme != null) {
		selectedScheme.className = '';
	}
	selectedScheme = this;
	this.className = 'selected';
	opts.scheme = this.getAttribute('data-item');
	repaint();
}

var fonts = [
	'Arial',
	'Courier New',
	'Times New Roman',
	'Verdana'
];

var visibleMenu = null;
var selectedLang = null;
var selectedScheme = null;

var opts = {
	lang:'cs',
	scheme:'vs2010',
	font:'Courier New',
	size:16
};

function repaint() {
	var t = document.getElementById('dResult');
	while (t.hasChildNodes()) {
		t.removeChild(t.lastChild);
	}
	var val = document.getElementById('inputCode').value;
	if (val == '') {
		t.style.display = 'none';
		return;
	} else {
		t.style.display = 'block';
	}
	var pre = document.createElement("pre")
	pre.setAttribute('data-snip-lang', opts.lang);
	pre.setAttribute('data-snip-scheme', opts.scheme);
	pre.setAttribute('data-snip-conf-font', opts.font);
	pre.setAttribute('data-snip-conf-size', opts.size);
	//pre.setAttribute('data-snip-painter-1', 'border => radius:5,width:1');
	pre.appendChild(document.createTextNode(val));
	t.appendChild(pre);
	snip2.compile(pre);
}

function hideVisible() {
	if (visibleMenu == null) return;
	visibleMenu.style.display = 'none';
	visibleMenu = null;
}

function optLiClick() {
	var button = this.parentNode.parentNode.parentNode.childNodes[1];
	button.innerHTML = this.innerHTML;
	hideVisible();
	opts.size = parseInt(this.getAttribute('data-item'));
	repaint();
}

function optLiFontClick() {
	var button = this.parentNode.parentNode.parentNode.childNodes[1];
	button.innerHTML = this.innerHTML;
	hideVisible();
	opts.font = this.getAttribute('data-item');
	repaint();
}

function optClick(el) {
	var ul = el.parentNode.childNodes[3].childNodes[1];
	if (ul.style.display == 'block') {
		ul.style.display = 'none';
	} else {
		hideVisible();
		ul.style.width = (el.offsetWidth - 2) + 'px';
		visibleMenu = ul;
		ul.style.display = 'block';
	}
}
