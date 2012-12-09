class SchemeFactoryController extends Factory
  Create: (code, font = 'Courier New', size = 13) ->
    s = @Find(code)
    return new s(font, size)

  List: ->
    a = []
    for p in @data
      a.push({code:p.code, name:p.title})
    a

SchemeFactory = new SchemeFactoryController()
