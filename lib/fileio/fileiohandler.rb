
class FileIOHandler
	@handler_for=""
	@platform=""
	
	def initialize(handler_for,platform)
		@handler_for=handler_for
		@platform=platform
	end
	
	def get_platform
		return @platform
	end
	
	def get_handler_for
		return @handler_for
	end
	
	def process_command(command)
		puts "default handler does nothing"
	end
	
end
