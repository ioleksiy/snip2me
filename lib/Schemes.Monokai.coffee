class MonokaiSch extends Scheme
  constructor: (font, size) ->
    super(font, size)
    @set('text-normal',        new SchemeDescription('#f8f8f2'))
    @set('text-keyword',       new SchemeDescription('#f92672'))
    @set('text-outlined',      new SchemeDescription('#66d9ef'))
    @set('text-string',        new SchemeDescription('#e6db74'))
    @set('text-comment',       new SchemeDescription('#75715e'))
    @set('text-directive',     new SchemeDescription('#a6e22e', 'bold'))
    @set('text-specialSymbol', new SchemeDescription('#fd971f', 'bold'))
    @set('bg',                 new SchemeDescription('#272822', 'solid'))

SchemeFactory.Register('monokai', MonokaiSch, 'Monokai')
