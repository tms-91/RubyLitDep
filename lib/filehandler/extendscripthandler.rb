class ExtendScriptHandler < FileHandler

	def initialize(handler_for)
		super(handler_for)
	end
	
  def compute_mainline(command, basepath, platform)
    raise "An ExtendScript should not be here"
		return nil
  end
  
end
