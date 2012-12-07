class SchemeFactoryController extends Factory
  Create: (code, font = 'Courier New', size = 13) ->
    s = @Find(code)
    return new s(font, size)

SchemeFactory = new SchemeFactoryController()
