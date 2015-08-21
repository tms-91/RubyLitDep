# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require 'test/unit'
require 'fileutils'

#Parser
Dir["lib/parser/*.rb"].each { |file|
  rfile = file.sub!("lib/","")
  require rfile }

#Parser
Dir["lib/filehandler/*.rb"].each { |file|
  rfile = file.sub!("lib/","")
  require rfile }

class AddfilecontentHandlertest < Test::Unit::TestCase
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
    @manual = @parserdispatcher.parse('showcases/testshowcases/pos/howto_addfilecontent.html')
    
    @fileoutput = FileOutput.new
    @fileoutput.add_command_handler(ReuseCodeHandler.new("ReuseCode"))
    @fileoutput.add_command_handler(RunOutputScriptHandler.new("RunOutputScript"))
  	@fileoutput.add_command_handler(ChangeFileLinesHandler.new("ChangeFileLines"))
  	@fileoutput.add_command_handler(ChangeFileRegexHandler.new("ChangeFileRegex"))
   	@fileoutput.add_command_handler(ExtendScriptHandler.new("ExtendScript"))
  	@fileoutput.add_command_handler(DeleteFileLinesHandler.new("DeleteFileLines"))
  	@fileoutput.add_command_handler(AddFileContentHandler.new("AddFileContent"))
  	@fileoutput.add_command_handler(RequestUserInputHandler.new("RequestUserInput"))
    @fileoutput.add_command_handler(RunEffectScriptHandler.new("RunEffectScript"))
    @fileoutput.add_command_handler(RunCheckScriptHandler.new("RunCheckScript"))
    Dir.mkdir("temp")
    @fileoutput.start_file_output(@manual, "temp", "WINDOWS")
  end
  
  def test_filecount
    assert_equal(1,Dir["temp"].length)
  end
  
  def test_mainrb
    f = File.open("temp/main.rb", "r")
    fragment = ""
    count=0
    while line = f.gets
      fragment+= line
      count+=1
    end
    f.close
    assert_equal(1,count)
    expected = "addfilecontent('testfolder/testfile.rb',0,\"filecontent\\nis\\nplaced\\nhere\\n\")\t#afctest\n"
    assert_equal(expected,fragment)
  end
  
  def teardown
    FileUtils.remove_dir("temp")
  end
end
