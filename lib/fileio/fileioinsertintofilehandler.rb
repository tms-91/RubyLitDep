require "fileio/fileiohandler"

class FileIOInsertIntoFileHandler < FileIOHandler

	def initialize(handler_for)
		super(handler_for)
	end
  
  def compute_mainline(command, basepath, platform)
    filename="'"+command.get_filename+"'"
    line=command.get_line
    substitute=command.get_codesnippet

    substitute=substitute.gsub(/"/,"\\\"")

    substitute=substitute.gsub("\n",'\n')

    substitute="\""+substitute+"\""

    id=command.get_id
    
    mainline = "insertintofile(#{filename},#{line},#{substitute})"
    if(id!=nil)
      mainline += "\t#"+id
    end
    return mainline
  end

end
