class PaddingAnalyzer extends Analyzer
  match: (reader, temporaryToken, tokens) ->
    return reader.current() == "\t"

  performAction: (temporaryToken, reader, tokens, flush) ->
    flush(temporaryToken)
    temporaryToken = null
    flush(new TokenPadding())
    temporaryToken