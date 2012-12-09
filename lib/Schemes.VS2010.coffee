class VisualStudioTenSch extends Scheme
  constructor: (@font, @size) ->
    @set('text-normal',        new SchemeDescription())
    @set('text-keyword',       new SchemeDescription('#0000FF'))
    @set('text-outlined',      new SchemeDescription('#008080'))
    @set('text-string',        new SchemeDescription('#800000'))
    @set('text-comment',       new SchemeDescription('#008000'))
    @set('text-directive',     new SchemeDescription('#000080', 'bold'))
    @set('text-specialSymbol', new SchemeDescription('#000000', 'bold'))
    @set('bg',                 new SchemeDescription('#FFFFFF', 'solid'))
    super(@font, @size)

SchemeFactory.Register('vs2010', VisualStudioTenSch, 'VS 2010')
