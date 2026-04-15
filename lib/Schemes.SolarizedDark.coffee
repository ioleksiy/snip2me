class SolarizedDarkSch extends Scheme
  constructor: (font, size) ->
    super(font, size)
    @set('text-normal',        new SchemeDescription('#93a1a1'))
    @set('text-keyword',       new SchemeDescription('#859900'))
    @set('text-outlined',      new SchemeDescription('#268bd2'))
    @set('text-string',        new SchemeDescription('#2aa198'))
    @set('text-comment',       new SchemeDescription('#657b83'))
    @set('text-directive',     new SchemeDescription('#d33682', 'bold'))
    @set('text-specialSymbol', new SchemeDescription('#cb4b16', 'bold'))
    @set('bg',                 new SchemeDescription('#002b36', 'solid'))

SchemeFactory.Register('solarized-dark', SolarizedDarkSch, 'Solarized Dark')
