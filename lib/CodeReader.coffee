class CodeReader
  constructor: (@data) ->
    @index = 0
    @buffer = ''
    
  current: ->
    return @data.substring(@index, @index+1)
    
  fetchPrev: (offset = 0) ->
    if (0 <= @index - offset)
      return @data.substring(@index - offset, @index - offset+1)
    return null
    
  skip: (offset) ->
    newIndex = @index + offset
    if (newIndex >= 0 && newIndex < @data.length)
      @index = newIndex

  fetchNext: (offset = 0) ->
    if (@data.length > @index + offset)
      return @data.substring(@index + offset, @index + offset+1)
    return null
  
  readNext: ->
    if (@index + 1 >= @data.length)
      return false
    @index += 1
    return true
    
  readUntil: (condition, withLast = true) ->
    @buffer = ''
    while(@readNext())
      if (condition(this))
        if (withLast)
          @buffer += @current()
        else
          @index--
        return true
      else
        @buffer += @current()
    @buffer += @current()
  
  readUntilChars: ->
    args = Array.prototype.slice.call(arguments)
    @readUntil((x) -> args.some((v) -> x.current() == v))
    
  readUntilCharsLast: (withLast) ->
    args = Array.prototype.slice.call(arguments)
    args = args.slice(1)
    @readUntil(((x) -> args.some((v) -> x.current() == v)), withLast)