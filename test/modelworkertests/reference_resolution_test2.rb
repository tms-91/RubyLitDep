# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
#Parser
Dir["parser/*.rb"].each { |file| 
  #rfile = file.sub!("lib/","")
  require file }
#Parser
Dir["modelwork/*.rb"].each { |file| 
  #rfile = file.sub!("lib/","")
  require file }
Dir["model/*.rb"].each { |file| 
  #rfile = file.sub!("lib/","")
  require file }

class ReferenceResolutionTest2 < Test::Unit::TestCase
  def setup
    parserdispatcher = ParserDispatcher.new
    parserdispatcher.register_parser(ChangeFileLinesParser.new("ChangeFileLines"))
    parserdispatcher.register_parser(ChangeFileRegexParser.new("ChangeFileRegex"))
    parserdispatcher.register_parser(CodeReferenceParser.new("CodeReference"))
    parserdispatcher.register_parser(ContinueFileParser.new("ContinueFile"))
    parserdispatcher.register_parser(DeclareReferenceParser.new("DeclareReference"))
    parserdispatcher.register_parser(DeclareVariablesParser.new("DeclareVariables"))
    parserdispatcher.register_parser(DeleteFileLinesParser.new("DeleteFileLines"))
    parserdispatcher.register_parser(InsertIntoFileParser.new("InsertIntoFile"))
    parserdispatcher.register_parser(RootFileParser.new("RootFile"))
    puts "registered parsers"
    @script = parserdispatcher.parse("../showcases/testshowcases/howto_referencewithpre.html")
    puts "parsed"
    modelworkerdispatcher = ModelWorkerDispatcher.new
    modelworkerdispatcher.register_modelworker(Codereferenceresolver.new)
    modelworkerdispatcher.register_modelworker(Continuefileresolver.new)
    puts "refine"
    @script = modelworkerdispatcher.refine(@script)
    puts "refined"
  end
  
  def test_cmdcount
    #TODO: Write test
    assert_equal(1, @script.get_number_commands())
    # assert_equal("foo", bar)
  end
  
  def test_referenceresolution
    assert_instance_of(RootFile, @script.get_command_at(0))
    rf = @script.get_command_at(0)
    
    assert_equal('1', rf.get_section)
    assert_equal('cloneRepo.sh', rf.get_filename)
    assert_equal('clone repository', rf.get_id)
    assert_equal('UNIX', rf.get_platform)
    assert_equal('sh', rf.get_executor)
    
    text = rf.get_codesnippet
    text.strip!
    expected = "cd ~/Code\n\n\n\ngit clone git://github.com/intercity/chef-repo.git chef_repo"
    assert_equal(expected, text)
  end
end