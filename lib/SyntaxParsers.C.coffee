class CParser extends SyntaxParser
  init: ->
    super()
    @registerAnalyzers([
      new CppCommentAnalyzer(),
      new CppCommentPlusAnalyzer(),
      new DelimiterAnalyzer()
    ])
    @registerKeywords(["auto",
                       "break","case","char","const",
                       "continue","default","do","double",
                       "else","enum","extern","float",
                       "for","goto","if","inline",
                       "int","long","register","restrict",
                       "return","short","signed","sizeof",
                       "static","struct","switch","typedef",
                       "union","unsigned","void","volatile",
                       "while","_Bool","_Complex","_Imaginary"])
    @registerOutlinedWords(["FILE",
                            "NULL",
                            "printf",
                            "scanf",
                            "size_t"])

ParserFactory.Register(['c','h'], CParser, "C")
