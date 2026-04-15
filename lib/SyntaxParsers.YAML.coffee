class YamlParser extends SyntaxParser
  init: ->
    super()
    @registerAnalyzers([
      new UnixCommentAnalyzer(),
      new DelimiterAnalyzer()
    ])
    @registerKeywords(["false",
                       "no",
                       "null",
                       "off",
                       "on",
                       "true",
                       "yes"])

ParserFactory.Register(['yaml','yml'], YamlParser, "YAML")
