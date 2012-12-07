class ParserFactory
  @parsers = new Array()

  @Register: (exts, parserName, title) ->
    for ext in exts
      p = {}
      p.ext = ext.toLowerCase()
      p.parser = parserName
      p.title = title
      @parsers.push(p)
    true

  @findParser: (extension) ->
    ext = extension.toLowerCase()
    for p in @parsers
      if (p.ext == ext)
        return p.parser
    null
    
  @makePrintable: (arr) ->
    arr.Print = () ->
      s = ''
      for t in @
        s += t.toStr() + "\r\n"
      return s
    arr

  @Parse: (ext, text) ->
    c = new CodeReader(text)
    p = ParserFactory.findParser(ext)
    if (p == null)
      return null
    p = new p()
    p.init()
    ParserFactory.makePrintable(p.tokenize(c))