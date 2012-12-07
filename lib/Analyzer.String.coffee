class StringAnalyzer extends Analyzer
  match: (reader, temporaryToken, tokens) ->
    ch = reader.current()
    return (ch == '"' || ch == "'")

  performAction: (temporaryToken, reader, tokens, flush) ->
    flush(temporaryToken)
    temporaryToken = null
    ch = reader.current()
    buff = ch
    while (true)
      if (!reader.readUntilChars(ch))
        buff += reader.buffer
        break
      buff += reader.buffer
      if (buff.length == 2)
        break
      if (buff.substring(buff.length - 2, buff.length - 1) == "\\" &&
          buff.substring(buff.length - 3, buff.length - 2) != "\\")
        continue
      break
    flush(new TokenString(buff))
    temporaryToken