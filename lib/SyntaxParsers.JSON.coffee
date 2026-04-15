class JsonParser extends SyntaxParser
  init: ->
    super()
    @registerAnalyzers([
      new DelimiterAnalyzer()
    ])
    @registerKeywords(["false",
                       "null",
                       "true"])

ParserFactory.Register(['json'], JsonParser, "JSON")
