# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require 'test/unit'

#Parser
Dir["lib/parser/*.rb"].each { |file|
  rfile = file.sub!("lib/","")
  require rfile }

class RunoutputscriptParsertest < Test::Unit::TestCase
  
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
    @manual = @parserdispatcher.parse('showcases/testshowcases/howto_outputscript.html')
  end
  
  def test_cmdcount
    assert_equal(1, @manual.get_number_commands)
  end
  
  def test_class
    cmd1 = @manual.get_command_at(0)
    assert_instance_of(RunOutputScript, cmd1)
  end
  
  def test_outputscript
    cmd1 = @manual.get_command_at(0)
    assert_equal("1", cmd1.get_section)
    assert_equal("echo.bat", cmd1.get_filename)
    assert_equal("echo", cmd1.get_id)
    assert_equal("WINDOWS", cmd1.get_platform)
    assert_equal("cmd /c", cmd1.get_executor)
    text = cmd1.get_fragment.strip!
    expected = "@echo off\necho 'Hello World'"
    assert_equal(expected,text)
  end
end
