# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
require 'test/unit'

#Parser
Dir["lib/parser/*.rb"].each { |file|
  rfile = file.sub!("lib/","")
  require rfile }

class RunrequestuserinputParsertestneg < Test::Unit::TestCase
  def setup
    @parserdispatcher = ParserDispatcher.new
    @parserdispatcher.register_parser(ChangeFileLinesParser.new("ChangeFileLines"))
    @parserdispatcher.register_parser(ChangeFileRegexParser.new("ChangeFileRegex"))
    @parserdispatcher.register_parser(ReuseFragmentParser.new("ReuseFragment"))
    @parserdispatcher.register_parser(ExtendScriptParser.new("ExtendScript"))
    @parserdispatcher.register_parser(DeclareFragmentParser.new("DeclareFragment"))
    @parserdispatcher.register_parser(RequestUserInputParser.new("RequestUserInput"))
    @parserdispatcher.register_parser(DeleteFileLinesParser.new("DeleteFileLines"))
    @parserdispatcher.register_parser(AddFileContentParser.new("AddFileContent"))
    @parserdispatcher.register_parser(RunOutputScriptParser.new("RunOutputScript"))
    @parserdispatcher.register_parser(RunEffectScriptParser.new("RunEffectScript"))
    @parserdispatcher.register_parser(RunCheckScriptParser.new("RunCheckScript"))
    
  end
  
  def test_exception
    assert_raise NoMethodError do 
      @manual = @parserdispatcher.parse('showcases/testshowcases/neg/howto_requestuserinput2.html')
    end
  end
  
  
  
end
