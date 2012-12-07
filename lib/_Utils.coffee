Array.prototype.some ?= (f) ->
  (return true if f x) for x in @
  return false

Array.prototype.every ?= (f) ->
  (return false if not f x) for x in @
  return true

String.prototype.toImg ?= () ->
  img = document.createElement("img")
  img.src = @
  img

String.prototype.trim ?= () ->
  @replace(/^\s+|\s+$/g, '')

String.prototype.dashToCamel ?= () ->
  return @replace(/\W+(.)/g, (x,chr)->chr.toUpperCase())