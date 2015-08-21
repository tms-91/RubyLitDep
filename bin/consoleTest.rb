# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

#~ require "./@fileoutput/fileio"
#~ require "./@fileoutput/fileiohandler"
#~ require "./@fileoutput/fileiohandlerregistry"
#~ require "./@fileoutput/fileiochangefilelineshandler"
#~ require "./@fileoutput/fileiochangefileregexhandler"
#~ require "./@fileoutput/fileiocodereferencehandler"
#~ require "./@fileoutput/fileiocontinuefilehandler"
#~ require "./@fileoutput/fileiodeclarevariableshandler"
#~ require "./@fileoutput/fileiodeletefilelineshandler"
#~ require "./@fileoutput/fileioinsertintofilehandler"
#~ require "./@fileoutput/fileiorootfilehandler"

#~ require "./model/block"
#~ require "./model/command"
#~ require "./model/changefilelines"
#~ require "./model/changefileregex"
#~ require "./model/codereference"
#~ require "./model/continuefile"
#~ require "./model/declarereference"
#~ require "./model/declarevariables"
#~ require "./model/deletefilelines"
#~ require "./model/addfilecontent"
#~ require "./model/rootfile"

#~ require "./parser/parserdispatcher"

#~ require "./modelworker/resolutiondispatcher"

#~ require 'fileutils'

require 'RubyLitDep'


def testfileio(script,platform)

	if(script==nil)
		script=Manual.new()
		script.add_command(RootFile.new("bla","echo \"bla\"",0,"bla.bat","win32",""))
		script.add_command(RootFile.new("bla2","@echo off\necho \"blablub\"\npause",0,"bla2.bat","win32",""))
	end
	fio = FileOutput.new(script,"testoutput") #necessary to give a subfolder here since the output mainfile is also called main.rb
	puts "Number of Commands (should be 2): "+fio.get_script.get_number_commands().to_s

	fio.add_command_handler(ReuseCodeHandler.new("CodeReference",platform))
	fio.add_command_handler(RunOutputScriptHandler.new("RootFile",platform))
	fio.add_command_handler(ChangeFileLinesHandler.new("ChangeFileLines",platform))
	fio.add_command_handler(ChangeFileRegexHandler.new("ChangeFileRegex",platform))
	fio.add_command_handler(ExtendScriptHandler.new("ContinueFile",platform))
	fio.add_command_handler(DeleteFileLinesHandler.new("DeleteFileLines",platform))
	fio.add_command_handler(AddFileContentHandler.new("InsertIntoFile",platform))
	fio.add_command_handler(RequestUserInputHandler.new("DeclareVariables",platform))

	begin
		fio.start_file_output()

	end

end

def test_fileiohandler_registry
	registry = FileHandlerRegistry.new
	handler = FileHandler.new("testhandler","win32")
	registry.add_handler(handler)

	handler2=registry.get_handler("testhandler")

	if(handler2.kind_of?(FileHandler))
		puts "success"
	else
		puts "failure"
	end
end

def testparser
  script = ParserDispatcher.new.parse("showcases/helloWorlds.html")
  script = ResolutionDispatcher.new.resolve(script)
  testfileio(script,"WINDOWS")
end

#testFileIO(nil)
#test_fileiohandler_registry()
script = testparser
#eval("puts 'works'")
