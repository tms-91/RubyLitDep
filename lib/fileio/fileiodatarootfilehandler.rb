# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class FileIODataRootFileHandler < FileIOHandler
  def initialize(handler_for)
    super(handler_for)
  end
  
  def compute_mainline(command, basepath, platform)
    mainline = ""
    if(platform==command.get_platform())
      out = File.new(basepath+"/"+command.get_filename(),"w+")
					
      out.puts(command.get_codesnippet())
      out.close()
				
      id=command.get_id
      filename = command.get_filename
      exec = command.get_executor
      var = command.get_varname
			
      part2="\{|i,o,t| replacevariable('"+basepath+"','"+var+"',o.read)\}"
      part2+="\t#"+id
      
      if(exec=="")
        mainline = "Open3.popen2e('"+filename+"') "
      elsif(exec.include?("$.$-f-$.$"))
        execplus = exec.gsub("$.$-f-$.$",filename)
        mainline = "Open3.popen2e('"+execplus+"') "
      else
        mainline = "Open3.popen2e('"+exec+" "+filename+"') "
      end
				
      mainline += part2
    end
    return mainline
  end
end
