class XmlParser extends SyntaxParser
  init: ->
    super()
    @registerAnalyzers([
      new DelimiterAnalyzer(['<','>','/','=','"',"'",'?',':']),
      new DelimiterAnalyzer()
    ])
    @registerKeywords(["encoding",
                       "version",
                       "xml",
                       "xmlns"])

ParserFactory.Register(['xml','xsd','svg'], XmlParser, "XML")
