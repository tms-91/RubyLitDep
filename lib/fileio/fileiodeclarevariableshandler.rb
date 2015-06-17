require "fileio/fileiohandler"

class FileIODeclareVariablesHandler < FileIOHandler

	def initialize(handler_for)
		super(handler_for)
	end
	
	def process_command(command,basepath,platform)
		variables = command.get_variables()
		
		return_string =""
		
		variables.each do |v| 
		  return_string=return_string+"#Variable: "+v+"\n"
		end
		
		#id=command.get_id
		return_hash = Hash.new()
			
		return_hash[:executor]=return_string
		return_hash[:type]="varOp"
		
			#return_hash[:id]=id
			
		return return_hash
	end
	
end