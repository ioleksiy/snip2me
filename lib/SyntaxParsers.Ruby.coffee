class RubyParser extends SyntaxParser
  init: ->
    super()
    @registerAnalyzers([
      new UnixCommentAnalyzer(),
      new DelimiterAnalyzer()
    ])
    @registerKeywords(["BEGIN",
                       "END",
                       "alias",
                       "and",
                       "begin",
                       "break",
                       "case",
                       "class",
                       "def",
                       "defined",
                       "do",
                       "else",
                       "elsif",
                       "end",
                       "ensure",
                       "false",
                       "for",
                       "if",
                       "module",
                       "next",
                       "nil",
                       "not",
                       "or",
                       "redo",
                       "rescue",
                       "retry",
                       "return",
                       "self",
                       "super",
                       "private",
                       "then",
                       "true",
                       "undef",
                       "unless",
                       "until",
                       "when",
                       "while",
                       "yield",
                       "__FILE__",
                       "__LINE__"])
    @registerOutlinedWords(["print"])

ParserFactory.Register(['rb','ruby'], RubyParser, "Ruby")