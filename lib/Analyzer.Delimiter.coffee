class DelimiterAnalyzer extends Analyzer
  constructor: (@delimeters = null) ->
    if (@delimeters == null)
      @delimeters = ['{', '}', '[', ']', '=',
                     ';', ':', '?', '(', ')',
                     ',', '<', '>', '.']
  
  match: (reader, temporaryToken, tokens) ->
    c = reader.current()
    return @delimeters.some((x) -> c == x)
  
  performAction: (temporaryToken, reader, tokens, flush) ->
    flush(temporaryToken)
    temporaryToken = null
    flush(new TokenDelimiter(reader.current()))
    temporaryToken