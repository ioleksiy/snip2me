class CoffeeScriptParser extends SyntaxParser
  init: ->
    super()
    @registerAnalyzers([
      new UnixCommentAnalyzer(),
      new DelimiterAnalyzer()
    ])
    @registerKeywords(["if",
                       "then","else","unless","and",
                       "new","return","try",
                       "catch","finally","throw",
                       "or","is","isnt",
                       "not","break","continue",
                       "by","of","where","when",
                       "until","for","in","while",
                       "delete","instanceof","typeof"
                       "switch","super",
                       "extends","class","case",
                       "default","do","function",
                       "with","const","let",
                       "debugger","enum","export","import",
                       "native","__extends","__hasProp"])

ParserFactory.Register(['coffee','coffeescript'],
                       CoffeeScriptParser, "Coffee Script")