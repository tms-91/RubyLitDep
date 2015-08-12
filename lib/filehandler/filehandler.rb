
class FileHandler
	@handler_for=""
	
	def initialize(handler_for)
		@handler_for=handler_for
	end
	
	def get_handler_for
		return @handler_for
	end
  
  def compute_mainline(command, basepath, platform)
    puts "default handler does nothing"
  end
	
end
