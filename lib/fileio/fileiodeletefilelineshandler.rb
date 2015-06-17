require "fileio/fileiohandler"

class FileIODeleteFileLinesHandler < FileIOHandler

	def initialize(handler_for)
		super(handler_for)
	end
		
	def process_command(command,basepath,platform)
		if(platform==command.get_platform())
				
			filename="'"+command.get_filename+"'"
			from=command.get_startline
			to=command.get_endline
			
			id=command.get_id
			
			return_hash = Hash.new()
			
			return_hash[:executor]="deletefilelines(#{filename},#{from},#{to})"
			return_hash[:type]="fileop"
			
			return_hash[:id]=id
			
			return return_hash
		else
			return nil
		end
	end
	
end
