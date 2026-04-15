class KotlinParser extends SyntaxParser
  init: ->
    super()
    @registerAnalyzers([
      new CppCommentAnalyzer(),
      new CppCommentPlusAnalyzer(),
      new DelimiterAnalyzer()
    ])
    @registerKeywords(["as",
                       "break","class","continue","do",
                       "else","false","for","fun",
                       "if","in","interface","is",
                       "null","object","package","return",
                       "super","this","throw","true",
                       "try","typealias","val","var",
                       "when","while"])
    @registerOutlinedWords(["Any",
                            "Array",
                            "Int",
                            "List",
                            "Map",
                            "String"])

ParserFactory.Register(['kt','kts','kotlin'],
                       KotlinParser, "Kotlin")
