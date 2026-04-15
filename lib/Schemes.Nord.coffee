class NordSch extends Scheme
  constructor: (font, size) ->
    super(font, size)
    @set('text-normal',        new SchemeDescription('#d8dee9'))
    @set('text-keyword',       new SchemeDescription('#81a1c1'))
    @set('text-outlined',      new SchemeDescription('#88c0d0'))
    @set('text-string',        new SchemeDescription('#a3be8c'))
    @set('text-comment',       new SchemeDescription('#616e88'))
    @set('text-directive',     new SchemeDescription('#b48ead', 'bold'))
    @set('text-specialSymbol', new SchemeDescription('#ebcb8b', 'bold'))
    @set('bg',                 new SchemeDescription('#2e3440', 'solid'))

SchemeFactory.Register('nord', NordSch, 'Nord')
