Array.prototype.some ?= (f) ->
  for x in @
    return true if f x
  false

Array.prototype.every ?= (f) ->
  for x in @
    return false if not f x
  true

String.prototype.toImg ?= () ->
  img = document.createElement("img")
  img.src = @
  img

String.prototype.trim ?= () ->
  @replace(/^\s+|\s+$/g, '')

String.prototype.dashToCamel ?= () ->
  return @replace(/\W+(.)/g, (x,chr)->chr.toUpperCase())