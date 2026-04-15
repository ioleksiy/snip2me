class GitHubDarkSch extends Scheme
  constructor: (font, size) ->
    super(font, size)
    @set('text-normal',        new SchemeDescription('#c9d1d9'))
    @set('text-keyword',       new SchemeDescription('#ff7b72'))
    @set('text-outlined',      new SchemeDescription('#79c0ff'))
    @set('text-string',        new SchemeDescription('#a5d6ff'))
    @set('text-comment',       new SchemeDescription('#8b949e'))
    @set('text-directive',     new SchemeDescription('#d2a8ff', 'bold'))
    @set('text-specialSymbol', new SchemeDescription('#ffa657', 'bold'))
    @set('bg',                 new SchemeDescription('#0d1117', 'solid'))

SchemeFactory.Register('github-dark', GitHubDarkSch, 'GitHub Dark')
