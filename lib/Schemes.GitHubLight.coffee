class GitHubLightSch extends Scheme
  constructor: (font, size) ->
    super(font, size)
    @set('text-normal',        new SchemeDescription('#24292f'))
    @set('text-keyword',       new SchemeDescription('#cf222e'))
    @set('text-outlined',      new SchemeDescription('#0550ae'))
    @set('text-string',        new SchemeDescription('#0a3069'))
    @set('text-comment',       new SchemeDescription('#6e7781'))
    @set('text-directive',     new SchemeDescription('#8250df', 'bold'))
    @set('text-specialSymbol', new SchemeDescription('#d1242f', 'bold'))
    @set('bg',                 new SchemeDescription('#ffffff', 'solid'))

SchemeFactory.Register('github-light', GitHubLightSch, 'GitHub Light')
