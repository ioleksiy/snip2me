class UnixCommentAnalyzer extends Analyzer
  match: (reader, temporaryToken, tokens) ->
    return (temporaryToken == null && reader.current() == '#')

  performAction: (temporaryToken, reader, tokens, flush) ->
    reader.readUntilCharsLast(false, "\r", "\n")
    flush(new TokenComment("#" + reader.buffer))
    temporaryToken