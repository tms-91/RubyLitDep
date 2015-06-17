require "fileio/fileiohandler"
require "model/rootfile"

class FileIORootFileHandler < FileIOHandler

	def initialize(handler_for)
		super(handler_for)
	end
	
	def process_command(command,basepath,platform)
		if(command.kind_of?(RootFile))
			puts "File: "+command.get_filename()
			puts "Platform: "+command.get_platform()
			unless command.get_executor().nil?
				puts "Executor: "+command.get_executor()
			end
			if(platform==command.get_platform())
				out = File.new(basepath+"/"+command.get_filename(),"w+")
					
				out.puts(command.get_codesnippet())
				out.close()
				
				id=command.get_id
				
				return_hash = Hash.new()
				
				return_hash[:filename]=command.get_filename()
				unless command.get_executor().nil?
					return_hash[:executor]=command.get_executor()
				end
				return_hash[:type]="execute"
	
				return_hash[:id]=id
				
				return return_hash
			else
				return nil
			end
			
		else
			raise command.class.to_s+" is not a RootFile"
		end
	end
	
end
