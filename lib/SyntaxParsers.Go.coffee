class GoParser extends SyntaxParser
  init: ->
    super()
    @registerAnalyzers([
      new CppCommentAnalyzer(),
      new CppCommentPlusAnalyzer(),
      new DelimiterAnalyzer()
    ])
    @registerKeywords(["break",
                       "case","chan","const","continue",
                       "default","defer","else","fallthrough",
                       "for","func","go","goto",
                       "if","import","interface","map",
                       "package","range","return","select",
                       "struct","switch","type","var"])
    @registerOutlinedWords(["append",
                            "bool",
                            "byte",
                            "error",
                            "float64",
                            "int",
                            "make",
                            "string"])

ParserFactory.Register(['go','golang'], GoParser, "Go")
