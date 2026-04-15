class CssParser extends SyntaxParser
  init: ->
    super()
    @registerAnalyzers([
      new CppCommentPlusAnalyzer(),
      new DelimiterAnalyzer()
    ])
    @registerKeywords(["align-items",
                       "background","border","color","display",
                       "font-family","font-size","grid","margin",
                       "padding","position","width"])
    @registerOutlinedWords(["em",
                            "px",
                            "rem",
                            "vh",
                            "vw"])

ParserFactory.Register(['css','scss','less'], CssParser, "CSS")
