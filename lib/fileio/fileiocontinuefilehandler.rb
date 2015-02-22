require "fileio/fileiohandler"

class FileIOContinueFileHandler < FileIOHandler

	def initialize(handler_for,platform)
		super(handler_for,platform)
	end
		
	def process_command(command,platform)
		raise "ContinueFile shouldnt be here"
		return nil
	end
	
end
