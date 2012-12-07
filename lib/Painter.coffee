class Painter
  settings: null
  scheme: null
  child: null
  w: -1
  h: -1
  pT: 0
  pB: 0
  pL: 0
  pR: 0
  
  constructor: (canvas, @settings, @scheme) ->
    @ctx = canvas.getContext('2d')
    
  withChild: (child) ->
    @child = child
    @

  scheme: ->
    return @scheme

  measure: ->
    w = 0
    h = 0
    if (@w > 0)
      w = @w
    if (@h > 0)
      h = @h
    if (@child != null)
      [iW, iH] = @child.measure()
      if (w < iW)
        w = iW
      h += iH
    w += @pL + @pR
    h += @pT + @pB
    [w,h]

  paint: ->
    @paintMe(0, 0)
    if (@child?)
      @child.paintMe(@pL, @pT)
    null

  paintMe: (x, y) ->
    null