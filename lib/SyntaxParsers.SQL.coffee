class SqlLineCommentAnalyzer extends Analyzer
  match: (reader, temporaryToken, tokens) ->
    atLineStart = (temporaryToken == null)
    hasFirstDash = (reader.current() == '-')
    hasSecondDash = (reader.fetchNext() == '-')
    return (atLineStart && hasFirstDash && hasSecondDash)

  performAction: (temporaryToken, reader, tokens, flush) ->
    reader.readUntilCharsLast(false, "\r", "\n")
    flush(new TokenComment("-" + reader.buffer))
    temporaryToken

class SqlParser extends SyntaxParser
  init: ->
    super()
    @registerAnalyzers([
      new SqlLineCommentAnalyzer(),
      new CppCommentPlusAnalyzer(),
      new DelimiterAnalyzer()
    ])
    @registerKeywords(["all",
                       "and","as","asc","by",
                       "case","create","delete","desc",
                       "distinct","drop","else","exists",
                       "from","group","having","in",
                       "insert","into","is","join",
                       "left","like","limit","not",
                       "null","on","or","order",
                       "right","select","set","table",
                       "then","union","update","values",
                       "when","where"])
    @registerOutlinedWords(["avg",
                            "count",
                            "max",
                            "min",
                            "sum"])

ParserFactory.Register(['sql'], SqlParser, "SQL")
