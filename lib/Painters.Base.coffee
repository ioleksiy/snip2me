class PaintersBase extends Painter
  constructor: (canvas, @params, settings, scheme) ->
    super(canvas, settings, scheme)
    @initialize()

  get: (key, defo = null) ->
    if (@params[key]?)
      return @params[key]
    c = @scheme.get(key)
    if (c?)
      return c.color
    defo

  setIfNull: (key, val) ->
    if (!@params[key]?)
      @params[key] = val
    true

  initialize: ->
    null