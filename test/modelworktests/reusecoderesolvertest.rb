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

class ReusefragmentResolvertest < Test::Unit::TestCase
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
    
    @modelworkerdispatcher = ModelWorkerDispatcher.new
    @modelworkerdispatcher.register_modelworker(ReuseFragmentResolver.new)
    @modelworkerdispatcher.register_modelworker(ExtendScriptResolver.new)
    
    @manual = @modelworkerdispatcher.refine(@manual)
  end
  
  def test_cmdcount
    assert_equal(1, @manual.get_number_commands)
  end
  
  def test_outputscriptcontent
    cmd = @manual.get_command_at(0)
    text = cmd.get_fragment.strip
    expected = "cd ~/Code\n\n\n\ngit clone git://github.com/intercity/chef-repo.git chef_repo"
    assert_equal(expected, text)
  end
  
end
