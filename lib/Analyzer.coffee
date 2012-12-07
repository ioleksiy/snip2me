class Analyzer
  match: (reader, temporaryToken, tokens) ->
    return false

  performAction: (temporaryToken, reader, tokens, flush) ->
    flush(temporaryToken)
    temporaryToken = null
    flush(new TokenUndefined())
    temporaryToken