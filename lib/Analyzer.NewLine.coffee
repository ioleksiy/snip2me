class NewLineAnalyzer extends Analyzer
  match: (reader, temporaryToken, tokens) ->
    ch = reader.current()
    return (ch == "\r" || ch == "\n")
  
  opposite: (c) ->
    return c == "\r" ? "\n" : "\r"

  performAction: (temporaryToken, reader, tokens, flush) ->
    flush(temporaryToken)
    temporaryToken = null
    flush(new TokenNewLine())
    if (reader.fetchNext() == @opposite(reader.current()))
      reader.skip(1)
    temporaryToken