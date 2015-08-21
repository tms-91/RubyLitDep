# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require 'test/unit'

#Parser
Dir["lib/parser/*.rb"].each { |file|
  rfile = file.sub!("lib/","")
  require rfile }

class RuneffectscriptParsertest < Test::Unit::TestCase
  
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
    @manual = @parserdispatcher.parse('showcases/testshowcases/pos/howto_effectscripttest.html')
  end
  
  def test_cmdcount
    assert_equal(3,@manual.get_number_commands)
  end
  
  def test_cmdclass
    assert_instance_of(RequestUserInput, @manual.get_command_at(0))
    assert_instance_of(RunEffectScript, @manual.get_command_at(1))
    assert_instance_of(RunOutputScript, @manual.get_command_at(2))
  end
  
  def test_requestuserinput1
    cmd = @manual.get_command_at(0)
    assert_equal(1,cmd.get_variables.length)
    assert_equal("name",cmd.get_variables.at(0))
  end
  
  def test_runeffectscript1
    cmd = @manual.get_command_at(1)
    assert_equal("1", cmd.get_section)
    assert_equal("helloworld.bat", cmd.get_filename)
    assert_equal("hello world win", cmd.get_id)
    assert_equal("WINDOWS", cmd.get_platform)
    assert_equal("cmd /c", cmd.get_executor)
    text = cmd.get_fragment.strip
    expected = "@echo off\necho Hello $.$-name-$.$!"
    assert_equal(expected, text)
    assert_equal("reecho",cmd.get_varname)
  end
  
  def test_runoutputscript1
    cmd = @manual.get_command_at(2)
    assert_equal("1", cmd.get_section)
    assert_equal("reecho.bat", cmd.get_filename)
    assert_equal("repeat echo", cmd.get_id)
    assert_equal("WINDOWS", cmd.get_platform)
    assert_equal("cmd /c", cmd.get_executor)
    text = cmd.get_fragment.strip
    expected = "@echo off\necho $.$-reecho-$.$"
    assert_equal(expected, text)
  end
  
end
