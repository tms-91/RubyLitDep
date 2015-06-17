require "fileio/fileiohandler"

class FileIODeclareReferenceHandler < FileIOHandler
	
	def initialize(handler_for)
		super(handler_for)
	end
	
	def process_command(command, basepath,platform)
		puts "default handler does nothing"
	end
	
end
