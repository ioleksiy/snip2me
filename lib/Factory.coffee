class Factory
  data: []

  Register: (code, item) ->
    p = {}
    p.code = code
    p.item = item
    @data.push(p)
    true
  
  Find: (code) ->
    for p in @data
      if (p.code == code)
        return p.item
    null