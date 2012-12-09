class Factory
  constructor: ->
    @data = []

  Register: (code, item, title = null) ->
    p = {}
    p.code = code
    p.item = item
    if (title?)
      p.title = title
    else
      p.title = code
    @data.push(p)
    true
  
  Find: (code) ->
    for p in @data
      if (p.code == code)
        return p.item
    null