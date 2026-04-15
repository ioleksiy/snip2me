class PythonParser extends SyntaxParser
  init: ->
    super()
    @registerAnalyzers([
      new UnixCommentAnalyzer(),
      new DelimiterAnalyzer()
    ])
    @registerKeywords(["and",
                       "as","assert","async","await",
                       "break","class","continue","def",
                       "del","elif","else","except",
                       "False","finally","for","from",
                       "global","if","import","in",
                       "is","lambda","None","nonlocal",
                       "not","or","pass","raise",
                       "return","True","try","while",
                       "with","yield"])
    @registerOutlinedWords(["dict",
                            "float",
                            "int",
                            "list",
                            "print",
                            "set",
                            "str",
                            "tuple"])

ParserFactory.Register(['py','python'], PythonParser, "Python")
