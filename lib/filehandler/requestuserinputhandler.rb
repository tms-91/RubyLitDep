class RequestUserInputHandler < FileHandler

	def initialize(handler_for)
		super(handler_for)
	end
  
  #TODO: Improve by adding a simple input dialog
  def compute_mainline(command, basepath, platform)
    variables = command.get_variables()
		
		mainline ="#Variable: "
		
		variables.each do |v| 
		  mainline += v + ","
		end
    return mainline.slice(0, mainline.length - 2)
  end
	
end
