class TypeScriptParser extends SyntaxParser
  init: ->
    super()
    @registerAnalyzers([
      new CppCommentAnalyzer(),
      new CppCommentPlusAnalyzer(),
      new DelimiterAnalyzer()
    ])
    @registerKeywords(["abstract",
                       "any","as","asserts","async",
                       "await","bigint","boolean","break",
                       "case","catch","class","const",
                       "constructor","continue","declare","default",
                       "delete","do","else","enum",
                       "export","extends","false","finally",
                       "for","from","function","if",
                       "implements","import","in","infer",
                       "instanceof","interface","is","keyof",
                       "let","module","namespace","never",
                       "new","null","number","object",
                       "private","protected","public","readonly",
                       "require","return","satisfies","static",
                       "string","super","switch","symbol",
                       "this","throw","true","try",
                       "type","typeof","undefined","unique",
                       "unknown","var","void","while"])
    @registerOutlinedWords(["Array",
                            "Map",
                            "Promise",
                            "Record",
                            "Set",
                            "String"])

ParserFactory.Register(['ts','typescript','tsx'],
                       TypeScriptParser, "TypeScript")
