# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require 'test/unit'

#Parser
Dir["lib/parser/*.rb"].each { |file|
  rfile = file.sub!("lib/","")
  require rfile }

class ReusefragmentParsertest < Test::Unit::TestCase
  
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
    @manual = @parserdispatcher.parse('showcases/testshowcases/pos/howto_reusefragment.html')
  end
  
  def test_cmdcount
    assert_equal(2, @manual.get_number_commands)
  end
  
  def test_class
    assert_instance_of(DeclareFragment,@manual.get_command_at(0))
    assert_instance_of(RunOutputScript,@manual.get_command_at(1))
  end
  
  def test_declarefragment1
    cmd = @manual.get_command_at(0)
    assert_equal("change to working folder", cmd.get_id)
    text = cmd.get_fragment.strip
    expected = "cd ~/Code"
    assert_equal(expected,text)
  end
  
  def test_runoutputscript1
    cmd = @manual.get_command_at(1)
    assert_equal("1", cmd.get_section)
    assert_equal("cloneRepo.sh", cmd.get_filename)
    assert_equal("clone repository", cmd.get_id)
    assert_equal("UNIX", cmd.get_platform)
    assert_equal("sh", cmd.get_executor)
    text = cmd.get_fragment.strip
    expected = "<!--\"\"LDS BeginReuseCode id=\"change to working folder\"-->\n\n<!--\"\"LDS EndReuseCode --><pre><code>\n\ngit clone git://github.com/intercity/chef-repo.git chef_repo"
    assert_equal(expected, text)
  end
  
end
