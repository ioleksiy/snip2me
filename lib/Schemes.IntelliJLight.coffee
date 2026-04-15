class IntelliJLightSch extends Scheme
  constructor: (font, size) ->
    super(font, size)
    @set('text-normal',        new SchemeDescription('#000000'))
    @set('text-keyword',       new SchemeDescription('#0033b3'))
    @set('text-outlined',      new SchemeDescription('#267f99'))
    @set('text-string',        new SchemeDescription('#067d17'))
    @set('text-comment',       new SchemeDescription('#8c8c8c'))
    @set('text-directive',     new SchemeDescription('#871094', 'bold'))
    @set('text-specialSymbol', new SchemeDescription('#1750eb', 'bold'))
    @set('bg',                 new SchemeDescription('#ffffff', 'solid'))

SchemeFactory.Register('intellij-light',
                       IntelliJLightSch,
                       'IntelliJ Light')
