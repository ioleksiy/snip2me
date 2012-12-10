class AptanaSch extends Scheme
  constructor: (@font, @size) ->
    @set('text-normal',        new SchemeDescription('#9b6f46'))
    @set('text-keyword',       new SchemeDescription('#cda772'))
    @set('text-outlined',      new SchemeDescription('#7187a3'))
    @set('text-string',        new SchemeDescription('#8f9d69'))
    @set('text-comment',       new SchemeDescription('#615e64'))
    @set('text-directive',     new SchemeDescription('#c86952', 'bold'))
    @set('text-specialSymbol', new SchemeDescription('#c86952', 'bold'))
    @set('bg',                 new SchemeDescription('#141414', 'solid'))
    super(@font, @size)

SchemeFactory.Register('aptana', AptanaSch, 'Aptana')
