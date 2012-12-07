class Scheme
  colors: new Object()
  
  constructor: (@font, @size) ->
  
  get: (key) ->
    if (@colors[key]?)
      return @colors[key]
    null

  set: (key, description) ->
    @colors[key] = description
    @