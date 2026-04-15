class XcodeLightSch extends Scheme
  constructor: (font, size) ->
    super(font, size)
    @set('text-normal',        new SchemeDescription('#1f1f24'))
    @set('text-keyword',       new SchemeDescription('#ad3da4'))
    @set('text-outlined',      new SchemeDescription('#0f68a0'))
    @set('text-string',        new SchemeDescription('#d12f1b'))
    @set('text-comment',       new SchemeDescription('#6c7986'))
    @set('text-directive',     new SchemeDescription('#78492a', 'bold'))
    @set('text-specialSymbol', new SchemeDescription('#205d95', 'bold'))
    @set('bg',                 new SchemeDescription('#ffffff', 'solid'))

SchemeFactory.Register('xcode-light', XcodeLightSch, 'Xcode Light')
