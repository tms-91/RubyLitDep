require "fileio/fileiohandler"

class FileIOInsertIntoFileHandler < FileIOHandler

	def initialize(handler_for,platform)
		super(handler_for,platform)
	end
		
	def process_command(command,platform)
#		if(self.get_platform()==command.get_platform())
			
      #'src\mysite\polls\models.py'
			filename="'"+command.get_filename+"'"
			line=command.get_line
			substitute=command.get_codesnippet
			
			substitute=substitute.gsub(/"/,"\\\"") 
			
			substitute=substitute.gsub("\n",'\n') 
			
			substitute="\""+substitute+"\""
			
			
			return_hash = Hash.new()
			
			return_hash[:executor]="insertintofile(#{filename},#{line},#{substitute})"
			return_hash[:type]="fileop"
			
			return return_hash
	#	else
	#		return nil
	#	end
	end
	
end
