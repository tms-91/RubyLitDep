require "fileio/fileiohandler"

class FileIOCodeReferenceHandler < FileIOHandler
	
	def initialize(handler_for,platform)
		super(handler_for,platform)
	end
	

	def process_command(command,platform)
		raise "A Code Reference should not be here"
		return nil
	end
	
end
