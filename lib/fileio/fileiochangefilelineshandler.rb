require "fileio/fileiohandler"

class FileIOChangeFileLinesHandler < FileIOHandler

	def initialize(handler_for)
		super(handler_for)
	end
  
  def compute_mainline(command, basepath, platform)
    filename="'"+command.get_filename+"'"
    from=command.get_startline
    to=command.get_endline
    substitute=command.get_codesnippet
    substitute=substitute.gsub(/"/,"\\\"") 
			
    substitute=substitute.gsub("\n",'\n') 
    substitute="\""+substitute+"\""
			
    id=command.get_id
    
    mainline = "changefilelines(#{filename},#{from},#{to},#{substitute})"
    if(id!=nil)
      mainline += "\t#"+id
    end
    
    return mainline
  end
	
end
