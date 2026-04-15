class PhpParser extends SyntaxParser
  init: ->
    super()
    @registerAnalyzers([
      new UnixCommentAnalyzer(),
      new CppCommentAnalyzer(),
      new CppCommentPlusAnalyzer(),
      new DelimiterAnalyzer()
    ])
    @registerKeywords(["abstract",
                       "array","as","break","case",
                       "class","const","continue","default",
                       "echo","else","elseif","extends",
                       "false","for","foreach","function",
                       "if","implements","include","namespace",
                       "new","null","private","protected",
                       "public","require","return","static",
                       "switch","throw","true","try",
                       "use","var","while"])
    @registerOutlinedWords(["Exception",
                            "PDO",
                            "Stringable"])

ParserFactory.Register(['php','phtml'], PhpParser, "PHP")
