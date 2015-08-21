# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require 'test/unit'

#Parser
Dir["lib/parser/*.rb"].each { |file|
  rfile = file.sub!("lib/","")
  require rfile }

#Modelwork
Dir["lib/modelwork/*.rb"].each { |file|
  rfile = file.sub!("lib/","")
  require rfile }

class ExtendscriptResolvertest < Test::Unit::TestCase
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
    
    @modelworkerdispatcher = ModelWorkerDispatcher.new
    @modelworkerdispatcher.register_modelworker(ReuseFragmentResolver.new)
    @modelworkerdispatcher.register_modelworker(ExtendScriptResolver.new)
    
    @manual = @modelworkerdispatcher.refine(@manual)
  end
  
  def test_cmdcounts
    assert_equal(3,@manual.get_number_commands)
  end
  
  def test_cmdclass
    assert_instance_of(RunOutputScript, @manual.get_command_at(0))
    assert_instance_of(RunEffectScript, @manual.get_command_at(1))
    assert_instance_of(RunCheckScript, @manual.get_command_at(2))
  end
  
  def test_runoutputscript
    expected="@echo off\necho 'Hello World'\necho 'Hello World2'"
    text = @manual.get_command_at(0).get_fragment.strip
    assert_equal(expected, text)
  end
  
  def test_runeffectscript
    expected="@echo off\necho 'Hello World'\necho 'Hello World2'"
    text = @manual.get_command_at(1).get_fragment.strip
    assert_equal(expected, text)
  end
  
  def test_runoutputscript
    expected="@echo off\necho 'Hello World'\necho 'Hello World2'"
    text = @manual.get_command_at(2).get_fragment.strip
    assert_equal(expected, text)
  end
  
end
