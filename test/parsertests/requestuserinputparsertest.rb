# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.


require 'test/unit'

#Parser
Dir["lib/parser/*.rb"].each { |file|
  rfile = file.sub!("lib/","")
  require rfile }

class RunrequestuserinputParsertest < Test::Unit::TestCase
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
    @manual = @parserdispatcher.parse('showcases/testshowcases/pos/howto_requestuserinput.html')
  end
  
  def test_cmdcount
    assert_equal(3, @manual.get_number_commands)
  end
  
  def test_class
    assert_instance_of(RequestUserInput,@manual.get_command_at(0))
    assert_instance_of(RequestUserInput,@manual.get_command_at(1))
    assert_instance_of(RequestUserInput,@manual.get_command_at(2))
  end
  
  def test_requestuserinput1
    cmd = @manual.get_command_at(0)
    assert_equal(2,cmd.get_variables.length)
    assert_equal("name1",cmd.get_variables.at(0))
    assert_equal("name2",cmd.get_variables.at(1))
  end
  
  def test_requestuserinput2
    cmd = @manual.get_command_at(1)
    assert_equal(1,cmd.get_variables.length)
    assert_equal("name1",cmd.get_variables.at(0))
  end
  
  def test_requestuserinput3
    cmd = @manual.get_command_at(2)
    assert_equal(1,cmd.get_variables.length)
    assert_equal("name1 name2",cmd.get_variables.at(0))
  end
  
  
  
end
