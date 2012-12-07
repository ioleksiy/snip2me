class SharpDirectiveAnalyzer extends Analyzer
  match: (reader, temporaryToken, tokens) ->
    return (temporaryToken == null && reader.current() == '#')

  performAction: (temporaryToken, reader, tokens, flush) ->
    reader.readUntilCharsLast(false, "\r", "\n")
    flush(new TokenSharpDirective("#" + reader.buffer))
    temporaryToken

class CSharpParser extends SyntaxParser
  init: ->
    super()
    @registerAnalyzers([
      new CppCommentAnalyzer(),
      new CppCommentPlusAnalyzer(),
      new SharpDirectiveAnalyzer(),
      new DelimiterAnalyzer()
    ])
    @registerKeywords(["abstract",
                       "as","base","bool","break","byte",
                       "case","catch","char","checked",
                       "class","const","continue","decimal",
                       "default","delegate","do","double",
                       "else","enum","event","explicit",
                       "extern","false","finally","fixed",
                       "float","for","foreach","goto","if",
                       "implicit","in","int","interface",
                       "internal","is","lock","long",
                       "namespace","new","null","object",
                       "operator","out","override","params",
                       "private","protected","public",
                       "readonly","ref","return","sbyte",
                       "sealed","short","sizeof","stackalloc",
                       "static","string","struct","switch",
                       "this","throw","true","try","typeof",
                       "uint","ulong","unchecked","unsafe",
                       "ushort","using","var","virtual",
                       "void","volatile","while"])
    @registerOutlinedWords(["String",
                            "Boolean",
                            "Int32",
                            "Int16",
                            "Int64",
                            "Double",
                            "StringBuilder",
                            "Object",
                            "KeyValuePair",
                            "List",
                            "Array",
                            "Dictionary",
                            "HashSet"])

ParserFactory.Register(['cs','csharp','c#'], CSharpParser, "C#")