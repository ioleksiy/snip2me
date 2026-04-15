class HtmlParser extends SyntaxParser
  init: ->
    super()
    @registerAnalyzers([
      new DelimiterAnalyzer(['<','>','/','=','"',"'",'!','-']),
      new DelimiterAnalyzer()
    ])
    @registerKeywords(["body",
                       "class","div","head","html",
                       "id","link","meta","script",
                       "span","style","title"])

ParserFactory.Register(['html','htm','xhtml'], HtmlParser, "HTML")
