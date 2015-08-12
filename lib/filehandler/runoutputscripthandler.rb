class RunOutputScriptHandler < FileHandler

	def initialize(handler_for)
		super(handler_for)
	end
  
  def compute_mainline(command, basepath, platform)
    mainline = ""
    if(platform==command.get_platform())
      filename = command.get_filename()
      out = File.new(basepath+"/"+filename,"w+")
					
      out.puts(command.get_fragment())
      out.close()
				
      id=command.get_id
      if(command.get_executor()==nil)
        mainline = "system('"+filename+"')"+"\t#"+id
      elsif(command.get_executor().include?("$.$-f-$.$"))
        executor = command.get_executor().gsub("$.$-f-$.$",filename)
        mainline = "system('"+executor+"')"+"\t#"+id
      else
        mainline = "system('"+command.get_executor()+" "+filename+"')"+"\t#"+id
      end
    end
    return mainline
  end
	
end
