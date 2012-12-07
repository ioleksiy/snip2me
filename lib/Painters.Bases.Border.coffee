class ServicePainterBorder extends PaintersBase
  defRad: 5
  defOffset: 1
  
  initialize: ->
    @setIfNull('radius', 0)
    @setIfNull('width', 1)
    r = parseInt(@get('radius'))
    if (r <= @defRad)
      r = @defRad + @defOffset
    else
      r = r + @defOffset
    @pL = r
    @pT = r
    @pB = r
    @pR = r
  
  paintMe: (x, y) ->
    cW = 0
    cH = 0
    if (@child?)
      [cW,cH] = @child.measure()
    
    o = @defOffset
    o2 = 2*@defOffset
    
    x1 = x+o
    y1 = y+o
    x2 = x+cW+@pL+@pR-o2
    y2 = y+cH+@pT+@pB-o2
    radius = parseInt(@get('radius'))
    
    @ctx.beginPath()

    @ctx.moveTo(x1 + radius, y1)
    @ctx.lineTo(x2 - radius, y1)
    @ctx.quadraticCurveTo(x2, y1, x2, y1 + radius)
    @ctx.lineTo(x2, y2 - radius)
    @ctx.quadraticCurveTo(x2, y2, x2 - radius, y2)
    @ctx.lineTo(x1 + radius, y2)
    @ctx.quadraticCurveTo(x1, y2, x1, y2 - radius)
    @ctx.lineTo(x1, y1 + radius)
    @ctx.quadraticCurveTo(x1, y1, x1 + radius, y1)
    @ctx.closePath()
    
    @ctx.strokeStyle = @get('fg', '#000000')
    @ctx.lineWidth = parseInt(@get('width'))
    @ctx.stroke()
    
    bg = @get('bg', 'transparent')
    if (bg != 'transparent')
      @ctx.fillStyle = bg
      @ctx.fill()
    
    null
  
PainterFactory.Register('border', ServicePainterBorder)