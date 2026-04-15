class DraculaSch extends Scheme
  constructor: (font, size) ->
    super(font, size)
    @set('text-normal',        new SchemeDescription('#f8f8f2'))
    @set('text-keyword',       new SchemeDescription('#ff79c6'))
    @set('text-outlined',      new SchemeDescription('#8be9fd'))
    @set('text-string',        new SchemeDescription('#f1fa8c'))
    @set('text-comment',       new SchemeDescription('#6272a4'))
    @set('text-directive',     new SchemeDescription('#bd93f9', 'bold'))
    @set('text-specialSymbol', new SchemeDescription('#ffb86c', 'bold'))
    @set('bg',                 new SchemeDescription('#282a36', 'solid'))

SchemeFactory.Register('dracula', DraculaSch, 'Dracula')
