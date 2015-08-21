# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require 'test/unit'

#Parser
Dir["lib/parser/*.rb"].each { |file|
  rfile = file.sub!("lib/","")
  require rfile }


class ChangefileregexParsertest < Test::Unit::TestCase
  
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
    @manual = @parserdispatcher.parse('showcases/testshowcases/pos/howto_changefileregex.html')
  end
  
  def test_cmdcount
    assert_equal(1,@manual.get_number_commands)
  end
  
  def test_class
    assert_instance_of(ChangeFileRegex, @manual.get_command_at(0))
  end
  
  def test_changefileregex1
    cmd = @manual.get_command_at(0)
    assert_equal("testfolder/testfile", cmd.get_filename)
    assert_equal("(abc)*",cmd.get_regex)
    assert_equal("cfrtest", cmd.get_id)
    text = cmd.get_fragment.strip
    expected = "filecontent\nis\nplaced\nhere"
    assert_equal(expected, text)
  end
  
end
