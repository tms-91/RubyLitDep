#modelworker
Dir["modelwork/*.rb"].each { |file| 
#  rfile = file.sub!("lib/","")
  require file }
  
require 'modelwork/modelworker'
require 'modelwork/modelworkerdispatcher'
require 'modelwork/modelworkerregistry'
require 'modelwork/reusefragmentresolver'
require 'modelwork/extendscriptresolver'
  
#Parser
Dir["parser/*.rb"].each { |file| 
 # rfile = file.sub!("lib/","")
  require file }

require 'parser/parserregistry'
require 'parser/parserdispatcher'
require 'parser/commandparser'
require 'parser/blockcommandparser'
require 'parser/addfilecontentparser'
require 'parser/changefilelinesparser'
require 'parser/changefileregexparser'
require 'parser/declarefragmentparser'
require 'parser/deletefilelinesparser'
require 'parser/extendscriptparser'
require 'parser/requestuserinputparser'
require 'parser/reusefragmentparser'
require 'parser/addfilecontentparser'
require 'parser/runcheckscriptparser'
require 'parser/runeffectscriptparser'
require 'parser/runoutputscriptparser'



#FileOutput
Dir["fileio/*.rb"].each { |file| 
#  rfile = file.sub!("lib/","")
  require file }
  
require 'filehandler/filehandler'
require 'filehandler/filehandlerregistry'
require 'filehandler/fileoutput'
require 'filehandler/filefunctions'
require 'filehandler/addfilecontenthandler'
require 'filehandler/changefilelineshandler'
require 'filehandler/changefileregexhandler'
require 'filehandler/declarefragmenthandler'
require 'filehandler/deletefilelineshandler'
require 'filehandler/extendscripthandler'
require 'filehandler/requestuserinputhandler'
require 'filehandler/reusecodehandler'
require 'filehandler/runcheckscripthandler'
require 'filehandler/runeffectscripthandler'
require 'filehandler/runoutputscripthandler'

require 'open3'

class TangleStage
  
  def initialize
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
    
    @modelworkerdispatcher = ModelWorkerDispatcher.new
    @modelworkerdispatcher.register_modelworker(ReuseFragmentResolver.new)
    @modelworkerdispatcher.register_modelworker(ExtendScriptResolver.new)
    
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
    
  end
  
  def get_parserdispatcher
    return @parserdispatcher
  end
  
  def get_modelworkerdispatcher
    return @modelworkerdispatcher
  end
  
  def get_fileoutput
    return @fileoutput
  end
  
  def tangle(basepath, htmlpath, platform) 
    
    script = @parserdispatcher.parse(htmlpath)
    script = @modelworkerdispatcher.refine(script)

    @fileoutput.start_file_output(script, basepath, platform)
    
    return declare_runelementstrings(script, platform)
  end
  
  def declare_runelementstrings (script, platform)
    runelements = Array.new
    script.get_commands.each { |cmd| 
      if cmd.is_a?(BlockCommand)
        if cmd.is_a?(RunScript)
          if cmd.get_platform == platform
            runelements.push(cmd.get_id)
          end
        else
          runelements.push(cmd.get_id)
        end
      end
      
      if cmd.is_a?(RequestUserInput)
        variables = cmd.get_variables.to_s
        variables = variables.gsub("[","")
        variables = variables.gsub("]","")
        variables = variables.gsub('", "',",")
        runelements.push("variables="+variables)
      end
      
      if cmd.is_a?(DeleteFileLines)
        runelements.push("Deleting lines "+cmd.get_startline+" to "+cmd.get_endline+" in "+cmd.get_filename)
      end
    }
    return runelements
  end
  
end
