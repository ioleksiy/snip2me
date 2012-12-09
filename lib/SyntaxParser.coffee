class SyntaxParser
  constructor: ->
    @outlinedWords = []
    @analyzers = []
    @keywords = []
    @registerAnalyzer = (analyzer) ->
      @analyzers.push(analyzer)
    @registerAnalyzers = (analyzers) ->
      for analyzer in analyzers
        @registerAnalyzer(analyzer)
    @registerKeyword = (keyword) ->
      @keywords.push(keyword)

    @registerKeywords = (keywords) ->
      for keyword in keywords
        @registerKeyword(keyword)
    
    @registerOutlinedWord = (word) ->
      @outlinedWords.push(word)

    @registerOutlinedWords = (words) ->
      for word in words
        @registerOutlinedWord(word)

    @beforeTokenFlush = (tokens, token) ->
      if (token instanceof TokenUndefined)
        content = token.content
        if (@keywords.some((x) -> content == x))
          return new TokenKeyword(content)
        if (@outlinedWords.some((x) -> x == content))
          return new TokenOutlined(content)
        else
          return new TokenNormal(content)
      else
        return token

  init: ->
    @registerAnalyzer(new NewLineAnalyzer())
    @registerAnalyzer(new SpaceAnalyzer())
    @registerAnalyzer(new PaddingAnalyzer())
    @registerAnalyzer(new StringAnalyzer())
  
  tokenize: (reader) ->
    tokens = new Array()
    flusher = (token) =>
      if (token == null)
        return
      token = @beforeTokenFlush(tokens, token)
      tokens.push(token)
    temporary = null
    temporary = @analyzeState(temporary, reader, tokens, flusher)
    while (reader.readNext())
      temporary = @analyzeState(temporary, reader, tokens, flusher)
    flusher(temporary)
    if (tokens.length > 0 && !(tokens[tokens.length-1] instanceof TokenNewLine))
      tokens.push(new TokenNewLine())
    return tokens

  analyzeState: (temporary, reader, tokens, flusher) ->
    for analyzer in @analyzers
      if (!analyzer.match(reader, temporary, tokens))
        continue
      temporary = analyzer.performAction(temporary, reader, tokens, flusher)
      temporary ?= null
      return temporary
    temporary ?= new TokenUndefined()
    temporary.addChar(reader.current())
    return temporary