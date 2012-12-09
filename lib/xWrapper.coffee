class SnipController
  constructor: ->
    @transform = (ext, text, scheme, painters = [], context = null) ->
      cont = context
      if (!cont?)
        cont = @mergeSettings(cont)
      tokens = ParserFactory.Parse(ext,text)
      if (tokens == null)
        console.log("snip2me: extension `"+ext+"` is not supported")
        return null
      dbg = document.getElementById('pre4debug')
      if (dbg?)
        dbg.innerHTML = tokens.Print()
      c = document.createElement("canvas")
      sh = SchemeFactory.Create(scheme, context.font, context.size)
      p = new CodePainter(c, tokens, sh, cont)
      for ps in painters
        tp = PainterFactory.Create(c, ps, cont, sh)
        if (!tp?)
          break
        tp.withChild(p)
        p = tp
      [w,h] = p.measure()
      c.width = w
      c.height = h
      p.paint()
      return c.toDataURL()

    @getPaintersFromElement = (el) ->
      code = 'data-snip-painter-'
      arr = []
      for attr in el.attributes
        if (attr.name.indexOf(code) != 0)
          continue
        v = {}
        v.num = parseInt(attr.name.substring(code.length))
        v.val = attr.value
        arr.push(v)
      arr.sort((a,b) -> b.num-a.num)
      r = []
      for a in arr
        r.push(a.val)
      r
    
    @transformElement = (el) ->
      ext = el.getAttribute('data-snip-lang')
      sch = el.getAttribute('data-snip-scheme')
      gist = el.getAttribute('data-snip-gist')
      painters = @getPaintersFromElement(el)
      if (!gist?)
        return @transformNonGist(el, ext, sch, painters)
      else
        return @transformGist(el, ext, sch, gist, painters)

    @transformNonGist = (elem, ext, sch, painters) ->
      uri = @transform(ext, elem.childNodes[0].nodeValue,
                       sch, painters, @readConfFromElement(elem))
      if (uri == null)
        return false
      img = uri.toImg()
      elem.parentNode.replaceChild(img,elem)
      true

    @transformGist = (el, ext, sch, gist, painters) ->
      return false

    @findAllElements = (attribute) ->
      matchingElements = []
      allElements = document.getElementsByTagName('*')
      for elem in allElements
        if (elem.getAttribute(attribute)?)
          matchingElements.push(elem)
      matchingElements
      
    @defaults = {
      minWidth: 0,
      font: 'Courier New',
      size: 12
    }
    
    @readConfFromElement = (el) ->
      code = 'data-snip-conf-'
      obj = {}
      for attr in el.attributes
        if (attr.name.indexOf(code) != 0)
          continue
        obj[attr.name.substring(code.length).dashToCamel()] = attr.value
      @mergeSettings(obj)
    
    @mergeSettings = (obj) ->
      @mergeObjs(@defaults, obj)

    @isInt = (n) ->
      return typeof n == 'number' && n % 1 == 0

    @mergeObjs = (obj1, obj2) ->
      obj3 = {}
      for p in Object.keys(obj1)
        v = null
        try
          if (obj1[p].constructor==Object)
            v = @mergeObjs(obj1[p], obj2[p])
          else
            if (obj2? && obj2[p]?)
              v = obj2[p]
            else
              v = obj1[p]
        catch error
          v = obj1[p]
        if (@isInt(obj1[p]))
          obj3[p] = parseInt(v)
        else
          obj3[p] = v
      obj3

    @isElement = (o) ->
      if ((typeof HTMLElement) == "object")
        return (o instanceof HTMLElement)
      return (o && (typeof o) == "object" &&
              o.nodeType == 1 && (typeof o.nodeName)=="string")

    @canRun = false
    @runChecked = false
    @checkVersions = (browser, version) ->
      switch browser
        when "opera"
          return version >= 12.1
        when "chrome"
          return version >= 22.0
        when "safari"
          return version >= 5.1
        when "firefox"
          return version >= 15.0
        when "msie"
          return version >= 9.0
        else true

  me: () ->
    if(!@isCompatible())
      return false
    elems = @findAllElements('data-snip-lang')
    for e in elems
      @transformElement(e)
    true

  compile: (element) ->
    if(!@isCompatible())
      return false
    if (@isElement(element))
      return @transformElement(element)
    else
      return @transform.apply(snip2, arguments)

  setSettings: (settings) ->
    @defaults = @mergeSettings(settings)

  isCompatible: ->
    if (@runChecked)
      return @canRun
    @runChecked = true
    N = navigator.appName
    ua = navigator.userAgent
    tem = null
    M= ua.match(/(opera|chrome|safari|firefox|msie)\/?\s*(\.?\d+(\.\d+)*)/i)
    if (M && (tem= ua.match(/version\/([\.\d]+)/i))!= null)
      M[2]= tem[1]
    if (M?)
      M = [M[1], M[2]]
    else
      M = [N, navigator.appVersion, '-?']
    @canRun = @checkVersions(M[0].toLowerCase(), parseFloat(M[1]))
    if (!@canRun)
      console.log("snip2me is not compatible with current browser")
    return @canRun

  parsers: ->
    ParserFactory.List()

  schemes: ->
    SchemeFactory.List()

root = exports ? this
root.snip2 = new SnipController()

autoLoader = ->
  if (root.snip?)
    root.snip2.setSettings.apply(root.snip2, [root.snip])
  root.snip2.me.apply(root.snip2)

if (window.addEventListener)
  window.addEventListener("load", autoLoader, false)
else
  window.attachEvent("onload", autoLoader)