require 'modelwork/modelworkerdispatcher'
require 'modelwork/codereferenceresolver'
require 'modelwork/continuefileresolver'

require 'fileio/fileio'
require 'fileio/fileiohandler'
require 'fileio/fileiohandlerregistry'
require 'fileio/fileiochangefilelineshandler'
require 'fileio/fileiochangefileregexhandler'
require 'fileio/fileiocodereferencehandler'
require 'fileio/fileiocontinuefilehandler'
require 'fileio/fileiodeclarevariableshandler'
require 'fileio/fileiodeletefilelineshandler'
require 'fileio/fileioinsertintofilehandler'
require 'fileio/fileiorootfilehandler'
require 'fileio/filefunctions'
require 'fileio/fileiodatarootfilehandler'
require 'fileio/fileioinclusionconstraintfilehandler'

require 'parser/parserdispatcher'
require 'parser/changefilelinesparser'
require 'parser/changefileregexparser'
require 'parser/codereferenceparser'
require 'parser/continuefileparser'
require 'parser/declarereferenceparser'
require 'parser/declarevariablesparser'
require 'parser/deletefilelinesparser'
require 'parser/insertintofileparser'
require 'parser/rootfileparser'
require 'parser/datarootfileparser'
require 'parser/inclusionconstraintfileparser'

require 'open3'

class TangleStage
  
  def initialize
    @parserdispatcher = ParserDispatcher.new
    @parserdispatcher.register_parser(ChangeFileLinesParser.new("ChangeFileLines"))
    @parserdispatcher.register_parser(ChangeFileRegexParser.new("ChangeFileRegex"))
    @parserdispatcher.register_parser(CodeReferenceParser.new("CodeReference"))
    @parserdispatcher.register_parser(ContinueFileParser.new("ContinueFile"))
    @parserdispatcher.register_parser(DeclareReferenceParser.new("DeclareReference"))
    @parserdispatcher.register_parser(DeclareVariablesParser.new("DeclareVariables"))
    @parserdispatcher.register_parser(DeleteFileLinesParser.new("DeleteFileLines"))
    @parserdispatcher.register_parser(InsertIntoFileParser.new("InsertIntoFile"))
    @parserdispatcher.register_parser(RootFileParser.new("RootFile"))
    @parserdispatcher.register_parser(DataRootFileParser.new("DataRootFile"))
    @parserdispatcher.register_parser(InclusionConstraintFileParser.new("InclusionConstraintFile"))
    
    @modelworkerdispatcher = ModelWorkerDispatcher.new
    @modelworkerdispatcher.register_modelworker(Codereferenceresolver.new)
    @modelworkerdispatcher.register_modelworker(Continuefileresolver.new)
    
    @fileio = FileIO.new
    @fileio.add_command_handler(FileIOCodeReferenceHandler.new("CodeReference"))
    @fileio.add_command_handler(FileIORootFileHandler.new("RootFile"))
  	@fileio.add_command_handler(FileIOChangeFileLinesHandler.new("ChangeFileLines"))
  	@fileio.add_command_handler(FileIOChangeFileRegexHandler.new("ChangeFileRegex"))
   	@fileio.add_command_handler(FileIOContinueFileHandler.new("ContinueFile"))
  	@fileio.add_command_handler(FileIODeleteFileLinesHandler.new("DeleteFileLines"))
  	@fileio.add_command_handler(FileIOInsertIntoFileHandler.new("InsertIntoFile"))
  	@fileio.add_command_handler(FileIODeclareVariablesHandler.new("DeclareVariables"))
    @fileio.add_command_handler(FileIODataRootFileHandler.new("DataRootFile"))
    @fileio.add_command_handler(FileIOInclusionConstraintFileHandler.new("InclusionConstraintFile"))
    
  end
  
  def get_parserdispatcher
    return @parserdispatcher
  end
  
  def get_modelworkerdispatcher
    return @modelworkerdispatcher
  end
  
  def get_fileio
    return @fileio
  end
  
  def tangle(basepath, htmlpath, platform) 
    
    script = @parserdispatcher.parse(htmlpath)
    script = @modelworkerdispatcher.refine(script)

    @fileio.start_file_output(script, basepath, platform)
    
    return declare_runelementstrings(script, platform)
  end
  
  def declare_runelementstrings (script, platform)
    runelements = Array.new
    script.get_commands.each { |cmd| 
      if cmd.is_a?(Block)
        if cmd.is_a?(RootFile)
          if cmd.get_platform == platform
            runelements.push(cmd.get_id)
          end
        else
          runelements.push(cmd.get_id)
        end
      end
      
      if cmd.is_a?(DeclareVariables)
        variables = cmd.get_variables.to_s
        variables = variables.gsub("[","")
        variables = variables.gsub("]","")
        runelements.push("variables="+variables)
      end
      
      if cmd.is_a?(DeleteFileLines)
        runelements.push("Deleting lines "+cmd.get_startline+" to "+cmd.get_endline+" in "+cmd.get_filename)
      end
    }
    return runelements
  end
  
  def pushexeclinks(runelements, htmlpath)
    htmlcontent = File.read(htmlpath)
    runelements.each { |runelement| 
      match = htmlcontent.match(/<!--""LDS.*#{runelement}.*/)
      
      unless match==nil 
        if match.to_s.include?("DeclareVariables")
          htmlcontent.sub!(match.to_s, "<a href='"+runelement+"'>Replace Variable</a></br>"+match.to_s)
        else
          htmlcontent.sub!(match.to_s, '</br><a style="text-decoration: none; background-color: #EEEEEE; color: #333333; padding: 2px 6px 2px 6px;  border-top: 1px solid #CCCCCC;  border-right: 1px solid #333333;  border-bottom: 1px solid #333333;  border-left: 1px solid #CCCCCC;" href="'+runelement+'">Execute</a></br></br>'+match.to_s)
        end
      else
        puts "Not Working:"+runelement
      end
    }
    newhtmlpath = htmlpath.sub(".html","executable.html")
    file = File.new(newhtmlpath,"w+")
    file.puts(htmlcontent)
    file.close
    
    return newhtmlpath
  end
  
  
end
