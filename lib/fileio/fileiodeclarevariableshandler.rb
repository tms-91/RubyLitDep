require "fileio/fileiohandler"

class FileIODeclareVariablesHandler < FileIOHandler

	def initialize(handler_for)
		super(handler_for)
	end
  
  def compute_mainline(command, basepath, platform)
    variables = command.get_variables()
		
		mainline ="#Variable: "
		
		variables.each do |v| 
		  mainline += v + ","
		end
    return mainline.slice(0, mainline.length - 2)
  end
	
end
