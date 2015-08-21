# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require 'test/unit'

#Parser
Dir["lib/parser/*.rb"].each { |file|
  rfile = file.sub!("lib/","")
  require rfile }

class ExtendscriptParsertest < Test::Unit::TestCase
  
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
    @manual = @parserdispatcher.parse('showcases/testshowcases/pos/howto_extendscript.html')
  end
  
  def test_cmdcount
    assert_equal(9,@manual.get_number_commands)
  end
  
  def test_class
    assert_instance_of(RunOutputScript,@manual.get_command_at(0))
    assert_instance_of(ExtendScript,@manual.get_command_at(1))
    assert_instance_of(ExtendScript,@manual.get_command_at(2))
    assert_instance_of(RunEffectScript,@manual.get_command_at(3))
    assert_instance_of(ExtendScript,@manual.get_command_at(4))
    assert_instance_of(ExtendScript,@manual.get_command_at(5))
    assert_instance_of(RunCheckScript,@manual.get_command_at(6))
    assert_instance_of(ExtendScript,@manual.get_command_at(7))
    assert_instance_of(ExtendScript,@manual.get_command_at(8))
  end
  
  def test_runoutputscript1
    cmd = @manual.get_command_at(0)
    assert_equal("2", cmd.get_section)
    assert_equal("echo.bat", cmd.get_filename)
    assert_equal("echo1", cmd.get_id)
    assert_equal("WINDOWS", cmd.get_platform)
    assert_equal("cmd /c", cmd.get_executor)
    text = cmd.get_fragment.strip
    expected = "echo 'Hello World'"
    assert_equal(expected, text)
  end
  
  def test_extendscript1
    cmd = @manual.get_command_at(1)
    assert_equal("3", cmd.get_section)
    assert_equal("echo.bat", cmd.get_filename)
    assert_equal("echo2", cmd.get_id)
    text = cmd.get_fragment.strip
    expected = "echo 'Hello World2'"
    assert_equal(expected, text)
  end
  
  def test_extendscript2
    cmd = @manual.get_command_at(2)
    assert_equal("1", cmd.get_section)
    assert_equal("echo.bat", cmd.get_filename)
    assert_equal("echo3", cmd.get_id)
    text = cmd.get_fragment.strip
    expected = "@echo off"
    assert_equal(expected, text)
  end
  
  def test_runeffectscript1
    cmd = @manual.get_command_at(3)
    assert_equal("2", cmd.get_section)
    assert_equal("echoe.bat", cmd.get_filename)
    assert_equal("echoe1", cmd.get_id)
    assert_equal("WINDOWS", cmd.get_platform)
    assert_equal("cmd /c", cmd.get_executor)
    text = cmd.get_fragment.strip
    expected = "echo 'Hello World'"
    assert_equal(expected, text)
    assert_equal("hello",cmd.get_varname)
  end
  
  def test_extendscripte1
    cmd = @manual.get_command_at(4)
    assert_equal("3", cmd.get_section)
    assert_equal("echoe.bat", cmd.get_filename)
    assert_equal("echoe2", cmd.get_id)
    text = cmd.get_fragment.strip
    expected = "echo 'Hello World2'"
    assert_equal(expected, text)
  end
  
  def test_extendscripte2
    cmd = @manual.get_command_at(5)
    assert_equal("1", cmd.get_section)
    assert_equal("echoe.bat", cmd.get_filename)
    assert_equal("echoe3", cmd.get_id)
    text = cmd.get_fragment.strip
    expected = "@echo off"
    assert_equal(expected, text)
  end
  
  def test_runcheckscript1
    cmd = @manual.get_command_at(6)
    assert_equal("2", cmd.get_section)
    assert_equal("echoc.bat", cmd.get_filename)
    assert_equal("echoc1", cmd.get_id)
    assert_equal("WINDOWS", cmd.get_platform)
    assert_equal("cmd /c", cmd.get_executor)
    assert_equal('Hello World\nHelloWorld2',cmd.get_value)
    text = cmd.get_fragment.strip
    expected = "echo 'Hello World'"
    assert_equal(expected, text)
  end
  
  def test_extendscriptc1
    cmd = @manual.get_command_at(7)
    assert_equal("3", cmd.get_section)
    assert_equal("echoc.bat", cmd.get_filename)
    assert_equal("echoc2", cmd.get_id)
    text = cmd.get_fragment.strip
    expected = "echo 'Hello World2'"
    assert_equal(expected, text)
  end
  
  def test_extendscriptc2
    cmd = @manual.get_command_at(8)
    assert_equal("1", cmd.get_section)
    assert_equal("echoc.bat", cmd.get_filename)
    assert_equal("echoc3", cmd.get_id)
    text = cmd.get_fragment.strip
    expected = "@echo off"
    assert_equal(expected, text)
  end
  
end
