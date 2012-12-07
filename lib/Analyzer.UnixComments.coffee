class CppCommentAnalyzer extends Analyzer
  match: (reader, temporaryToken, tokens) ->
    return (temporaryToken == null &&
            reader.current() == '/' &&
            reader.fetchNext() == '/')

  performAction: (temporaryToken, reader, tokens, flush) ->
    reader.readUntilCharsLast(false, "\r", "\n")
    flush(new TokenComment("/" + reader.buffer))
    temporaryToken

class CppCommentPlusAnalyzer extends Analyzer
  match: (reader, temporaryToken, tokens) ->
    return (temporaryToken == null &&
            reader.current() == '/' &&
            reader.fetchNext() == '*')

  performAction: (temporaryToken, reader, tokens, flush) ->
    reader.readUntil(((x) -> x.current() == '*' && x.fetchNext() == '/'))
    flush(new TokenComment("/" + reader.buffer + "/"))
    temporaryToken