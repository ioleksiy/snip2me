class SwiftParser extends SyntaxParser
  init: ->
    super()
    @registerAnalyzers([
      new CppCommentAnalyzer(),
      new CppCommentPlusAnalyzer(),
      new DelimiterAnalyzer()
    ])
    @registerKeywords(["as",
                       "break","case","class","continue",
                       "default","defer","do","else",
                       "enum","extension","false","for",
                       "func","guard","if","import",
                       "in","init","let","nil",
                       "protocol","return","self","struct",
                       "super","switch","throw","throws",
                       "true","try","var","where",
                       "while"])
    @registerOutlinedWords(["Array",
                            "Bool",
                            "Double",
                            "Int",
                            "String"])

ParserFactory.Register(['swift'], SwiftParser, "Swift")
