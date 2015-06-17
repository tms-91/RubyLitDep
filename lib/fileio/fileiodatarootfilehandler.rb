# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class FileIODataRootFileHandler < FileIOHandler
  def initialize(handler_for)
    super(handler_for)
  end
  
  def process_command(command, basepath, platform)
    if(platform==command.get_platform())
      out = File.new(basepath+"/"+command.get_filename(),"w+")
					
      out.puts(command.get_codesnippet())
      out.close()
				
      id=command.get_id
				
      return_hash = Hash.new()
				
      return_hash[:filename]=command.get_filename()
      unless command.get_executor().nil?
        return_hash[:executor]=command.get_executor()
      end
      return_hash[:type]="dataFlow"
	
      return_hash[:id]=id
      
      return_hash[:var]=command.get_varname
				
      return return_hash
    else
      return nil
    end
  end
end
