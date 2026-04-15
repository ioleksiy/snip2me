class RustParser extends SyntaxParser
  init: ->
    super()
    @registerAnalyzers([
      new CppCommentAnalyzer(),
      new CppCommentPlusAnalyzer(),
      new DelimiterAnalyzer()
    ])
    @registerKeywords(["as",
                       "async","await","break","const",
                       "continue","crate","dyn","else",
                       "enum","extern","false","fn",
                       "for","if","impl","in",
                       "let","loop","match","mod",
                       "move","mut","pub","ref",
                       "return","self","Self","static",
                       "struct","super","trait","true",
                       "type","unsafe","use","where",
                       "while"])
    @registerOutlinedWords(["Option",
                            "Result",
                            "String",
                            "Vec",
                            "println",
                            "format"])

ParserFactory.Register(['rs','rust'], RustParser, "Rust")
