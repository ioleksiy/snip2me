class TokenSharpDirective extends SyntaxToken
  constructor: (@content='') ->
    super('directive', @content)