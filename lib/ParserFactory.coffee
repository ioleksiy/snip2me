class ParserFactory
  @parsers = []
  @list = []

  @Register: (exts, parserName, title) ->
    @list.push({name:title,code:exts[0]})
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

  @List: ->
    @list

  @Parse: (ext, text) ->
    c = new CodeReader(text)
    p = ParserFactory.findParser(ext)
    if (p == null)
      return null
    p = new p()
    p.init()
    ParserFactory.makePrintable(p.tokenize(c))