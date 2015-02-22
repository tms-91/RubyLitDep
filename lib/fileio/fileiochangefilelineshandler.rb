require "fileio/fileiohandler"

class FileIOChangeFileLinesHandler < FileIOHandler

	def initialize(handler_for,platform)
		super(handler_for,platform)
	end
	
	def process_command(command,platform)
#		if(self.get_platform()==command.get_platform())
				
			filename="'"+command.get_filename+"'"
			from=command.get_startline
			to=command.get_endline
			substitute=command.get_codesnippet
			substitute=substitute.gsub(/"/,"\\\"") 
			
			substitute=substitute.gsub("\n",'\n') 
			substitute="\""+substitute+"\""
			
			id=command.get_id
			
			
			return_hash = Hash.new()
			
			return_hash[:executor]="changefilelines(#{filename},#{from},#{to},#{substitute})"
			return_hash[:type]="fileop"
			return_hash[:id]=id
			
			return return_hash
#		else
#			return nil
#		end
	end
	
end
