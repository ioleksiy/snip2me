class SpaceAnalyzer extends Analyzer
  match: (reader, temporaryToken, tokens) ->
    return reader.current() == ' '

  performAction: (temporaryToken, reader, tokens, flush) ->
    flush(temporaryToken)
    temporaryToken = null
    flush(new TokenSpace())
    temporaryToken