class OneDarkSch extends Scheme
  constructor: (font, size) ->
    super(font, size)
    @set('text-normal',        new SchemeDescription('#abb2bf'))
    @set('text-keyword',       new SchemeDescription('#c678dd'))
    @set('text-outlined',      new SchemeDescription('#61afef'))
    @set('text-string',        new SchemeDescription('#98c379'))
    @set('text-comment',       new SchemeDescription('#5c6370'))
    @set('text-directive',     new SchemeDescription('#e5c07b', 'bold'))
    @set('text-specialSymbol', new SchemeDescription('#56b6c2', 'bold'))
    @set('bg',                 new SchemeDescription('#282c34', 'solid'))

SchemeFactory.Register('one-dark', OneDarkSch, 'One Dark')
