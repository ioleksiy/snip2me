class CodePainter extends Painter
  constructor: (canvas, @tokens, scheme, conf) ->
    super(canvas, conf, scheme)
    #@settings
    [@w, @h] = @calculate()
    
  withChild: (child) ->
    @child = null
    @
    
  calculate: ->
    maxW = 0
    maxH = 0
    currH = 0
    currW = 0
    
    for t in @tokens
      [w,h] = @measureToken(t)
      currW += w
      if (t instanceof TokenNewLine)
        if (currH < h)
          currH = h
        maxH += currH
        if (maxW < currW)
          maxW = currW
        currH = 0
        currW = 0
        continue
        
    maxH += currH
    if (maxW < currW)
      maxW = currW
    if (maxW < @settings.minWidth)
      maxW = @settings.minWidth
    [maxW, maxH]
    
  prepareContextForText: (tokenCode) ->
    shDescription = @scheme.get('text-'+tokenCode)
    if (shDescription == null)
      shDescription = @scheme.get('text-normal')
    if (shDescription == null)
      shDescription = new SchemeDescription()
    @ctx.textBaseline = 'top'
    @ctx.textAlign = 'left'
    @ctx.font = shDescription.param +
                " " + @scheme.size + "px " +
                @scheme.font
    @ctx.fillStyle = shDescription.color
    return @scheme.size

  measureToken: (t) ->
    c = t.content
    if (t instanceof TokenSpace)
      c = " "
    s = @prepareContextForText(t.code())
    dim = @ctx.measureText(c)
    [Math.round(dim.width), s]
    
  drawToken: (t, x, y) ->
    c = t.content
    if (t instanceof TokenSpace)
      c = " "
    s = @prepareContextForText(t.code())
    dim = @ctx.measureText(c)
    @ctx.fillText(c, x, y)
    [Math.round(dim.width), s]

  paintMe: (x, y) ->
    offX = x
    offY = y
    cH = 0
    for t in @tokens
      [w,h] = @drawToken(t, offX, offY)
      if (cH < h)
        cH = h
      offX += w
      if (t instanceof TokenNewLine)
        offX = x
        offY += cH
        continue
    null