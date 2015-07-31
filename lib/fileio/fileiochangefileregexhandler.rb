require "fileio/fileiohandler"

class FileIOChangeFileRegexHandler < FileIOHandler
	
	def initialize(handler_for)
		super(handler_for)
	end
  
  def compute_mainline(command, basepath, platform)
    filename="'"+command.get_filename+"'"
    regex="\""+command.get_regex+"\""
    substitute=command.get_codesnippet
    substitute=substitute.gsub(/"/,"\\\"") 
			
    substitute=substitute.gsub("\n",'\n') 
    substitute="\""+substitute+"\""
    id=command.get_id
    
    mainline = "changefileregex(#{filename},#{regex},#{substitute})"
    
    if(id!=nil)
      mainline += "\t#"+id
    end
    return mainline
  end
	
end
