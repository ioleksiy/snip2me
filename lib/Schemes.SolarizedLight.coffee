class SolarizedLightSch extends Scheme
  constructor: (font, size) ->
    super(font, size)
    @set('text-normal',        new SchemeDescription('#586e75'))
    @set('text-keyword',       new SchemeDescription('#859900'))
    @set('text-outlined',      new SchemeDescription('#268bd2'))
    @set('text-string',        new SchemeDescription('#2aa198'))
    @set('text-comment',       new SchemeDescription('#93a1a1'))
    @set('text-directive',     new SchemeDescription('#d33682', 'bold'))
    @set('text-specialSymbol', new SchemeDescription('#b58900', 'bold'))
    @set('bg',                 new SchemeDescription('#fdf6e3', 'solid'))

SchemeFactory.Register('solarized-light', SolarizedLightSch, 'Solarized Light')
