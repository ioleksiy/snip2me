class BashParser extends SyntaxParser
  init: ->
    super()
    @registerAnalyzers([
      new UnixCommentAnalyzer(),
      new DelimiterAnalyzer()
    ])
    @registerKeywords(["case",
                       "do","done","elif","else",
                       "esac","fi","for","function",
                       "if","in","select","then",
                       "time","until","while"])
    @registerOutlinedWords(["echo",
                            "export",
                            "local",
                            "printf",
                            "readonly",
                            "source"])

ParserFactory.Register(['sh','bash','zsh'], BashParser, "Bash")
