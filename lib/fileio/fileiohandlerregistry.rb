require "fileio/fileiohandler"

class FileIOHandlerRegistry
	@entries = Hash.new

	def initialize
		@entries = Hash.new
	end

	def add_handler(handler)
		if(handler.kind_of?(FileIOHandler))
			handler_for=handler.get_handler_for
			@entries[handler_for] = handler
		end
	end

	def get_handler(handler_for)
		return @entries[handler_for]
	end
end

