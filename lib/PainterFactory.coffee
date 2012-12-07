class PainterFactoryController extends Factory
  constructor: ->
    super()

    @processParams = (params) ->
      a = params.trim().split(',')
      s = '{'
      f = true
      for p in a
        kv = p.trim().split(':', 2)
        if (kv.length != 2)
          continue
        if (f)
          f = false
        else
          s += ','
        s += '"'+kv[0]+'":"'+kv[1]+'"'
      s += '}'
      s

  Create: (canvas, initString, context, scheme) ->
    a = initString.split('=>',2)
    if (a.length < 1)
      return null
    code = a[0].trim().toLowerCase()
    p = @Find(code)
    if (!p?)
      return null
    par = {}
    if (a.length > 1)
      par = JSON.parse(@processParams(a[1]))
    return new p(canvas, par, context, scheme)

PainterFactory = new PainterFactoryController()
