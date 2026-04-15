class CppParser extends SyntaxParser
  init: ->
    super()
    @registerAnalyzers([
      new CppCommentAnalyzer(),
      new CppCommentPlusAnalyzer(),
      new DelimiterAnalyzer()
    ])
    @registerKeywords(["alignas",
                       "alignof","and","asm","auto",
                       "bool","break","case","catch",
                       "char","class","const","constexpr",
                       "continue","decltype","default","delete",
                       "do","double","else","enum",
                       "explicit","export","extern","false",
                       "final","float","for","friend",
                       "goto","if","inline","int",
                       "long","mutable","namespace","new",
                       "noexcept","nullptr","operator","or",
                       "private","protected","public","register",
                       "return","short","signed","sizeof",
                       "static","struct","switch","template",
                       "this","throw","true","try",
                       "typedef","typename","union","unsigned",
                       "using","virtual","void","volatile",
                       "while"])
    @registerOutlinedWords(["std",
                            "string",
                            "vector",
                            "map",
                            "set",
                            "cout",
                            "cin"])

ParserFactory.Register(['cpp','cxx','cc','hpp','hh'],
                       CppParser, "C++")
