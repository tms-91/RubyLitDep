require "fileio/fileiohandler"

class FileIODeclareReferenceHandler < FileIOHandler
	@handler_for=""
	
	def initialize(handler_for,platform)
		super(handler_for,platform)
	end
	
	def get_handler_for
		return @handler_for
	end
	
	def process_command(command, platform)
		puts "default handler does nothing"
	end
	
end
