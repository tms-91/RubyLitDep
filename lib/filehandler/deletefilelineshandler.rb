class DeleteFileLinesHandler < FileHandler

	def initialize(handler_for)
		super(handler_for)
	end
  
  def compute_mainline(command, basepath, platform)
    filename="'"+command.get_filename+"'"
    from=command.get_startline
    to=command.get_endline
			
    id=command.get_id
    
    mainline = "deletefilelines(#{filename},#{from},#{to})"
    if(id!=nil)
      mainline += "\t#"+id
    end
    return mainline
  end
	
end
