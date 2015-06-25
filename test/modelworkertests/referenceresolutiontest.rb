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

class ReferenceResolutionTest < Test::Unit::TestCase
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
    @script = parserdispatcher.parse("../showcases/testshowcases/testhowto.html")
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
    assert_equal(4, @script.get_number_commands())
    # assert_equal("foo", bar)
  end
  
  def test_referenceresolution
    assert_instance_of(RootFile, @script.get_command_at(3))
    bf = @script.get_command_at(3)
    
    assert_equal('1', bf.get_section)
    assert_equal('echopause.bat', bf.get_filename)
    assert_equal('echo plus pause', bf.get_id)
    assert_equal('WINDOWS', bf.get_platform)
    assert_equal('cmd /c', bf.get_executor)
    
    text = bf.get_codesnippet
    text.strip!
    expected = "@echo off\necho Hello $.$-name-$.$!\n\necho mytest\npause"
    assert_equal(expected, text)
  end
end