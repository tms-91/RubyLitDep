require "fileio/fileiohandler"

class FileIOContinueFileHandler < FileIOHandler

	def initialize(handler_for)
		super(handler_for)
	end
		
	def process_command(command,basepath,platform)
		raise "ContinueFile shouldnt be here"
		return nil
	end
	
end
