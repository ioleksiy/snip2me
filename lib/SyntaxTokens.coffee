class TokenUndefined extends SyntaxToken
  constructor: (@content='') ->
    super('undefined', @content)

class TokenSpace extends SyntaxToken
  constructor: (@content='') ->
    super('space', @content)

class TokenNewLine extends SyntaxToken
  constructor: (@content='') ->
    super('new-line', @content)

class TokenDelimiter extends SyntaxToken
  constructor: (@content='') ->
    super('delimiter', @content)

class TokenComment extends SyntaxToken
  constructor: (@content='') ->
    super('comment', @content)

class TokenPadding extends SyntaxToken
  constructor: (@content='') ->
    super('padding', @content)

class TokenString extends SyntaxToken
  constructor: (@content='') ->
    super('string', @content)

class TokenKeyword extends SyntaxToken
  constructor: (@content='') ->
    super('keyword', @content)

class TokenNormal extends SyntaxToken
  constructor: (@content='') ->
    super('normal', @content)

class TokenOutlined extends SyntaxToken
  constructor: (@content='') ->
    super('outlined', @content)