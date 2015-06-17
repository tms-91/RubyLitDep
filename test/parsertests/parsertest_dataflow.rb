# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'parser/parserdispatcher'
#Parser
Dir["parser/*.rb"].each { |file| 
  Dir.pwd
  rfile = file.sub!("lib/","")
  require file }
#Model
Dir["model/*.rb"].each { |file| 
  rfile = file.sub!("lib/","")
  require file }


# This test focuses on a single particular showcase
class ParserTestDataFlow < Test::Unit::TestCase
  
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
    parserdispatcher.register_parser(DataRootFileParser.new("DataRootFile"))
    @script = parserdispatcher.parse("../showcases/testshowcases/howto_dataflowtest.html")
  end
  
  def test_cmdcount
    #TODO: Write test
    assert_equal(3, @script.get_number_commands())
    # assert_equal("foo", bar)
  end
  
  # see line 26 in webserver.html
  def test_datarootfile1
    assert_instance_of(DataRootFile, @script.get_command_at(1))
    dr = @script.get_command_at(1)
    assert_equal("1", dr.get_section)
    assert_equal("reecho", dr.get_varname)
  end
  
  def test_rootfile1
    assert_instance_of(RootFile, @script.get_command_at(2))
    dr = @script.get_command_at(2)
    assert_equal("1", dr.get_section)
    assert_equal("repeat echo", dr.get_id)
  end
end
