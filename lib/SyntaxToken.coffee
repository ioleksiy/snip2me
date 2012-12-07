class SyntaxToken
  constructor: (@type='(null)', @content='') ->
  
  code: ->
    @type
  
  addChar: (chr) ->
    @content += chr
  
  toStr: () ->
    return @type.toString() + ': ' + @content.toString()