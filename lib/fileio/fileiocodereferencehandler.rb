require "fileio/fileiohandler"

class FileIOCodeReferenceHandler < FileIOHandler
	
	def initialize(handler_for)
		super(handler_for)
	end
	

	def process_command(command,basepath,platform)
		raise "A Code Reference should not be here"
		return nil
	end
	
end
