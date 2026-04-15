class JavaScriptParser extends SyntaxParser
  init: ->
    super()
    @registerAnalyzers([
      new CppCommentAnalyzer(),
      new CppCommentPlusAnalyzer(),
      new DelimiterAnalyzer()
    ])
    @registerKeywords(["await",
                       "break","case","catch","class",
                       "const","continue","debugger","default",
                       "delete","do","else","export",
                       "extends","finally","for","function",
                       "if","import","in","instanceof",
                       "let","new","return","super",
                       "switch","this","throw","try",
                       "typeof","var","void","while",
                       "with","yield"])
    @registerOutlinedWords(["Array",
                            "Boolean",
                            "Date",
                            "Map",
                            "Number",
                            "Object",
                            "Promise",
                            "RegExp",
                            "Set",
                            "String"])

ParserFactory.Register(['js','javascript','mjs','cjs'],
                       JavaScriptParser, "JavaScript")
