# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class FileIOInclusionConstraintFileHandler < FileIOHandler
  def initialize(handler_for)
    super(handler_for)
  end
  
  def compute_mainline(command, basepath, platform)
    mainline = ""
    if(platform==command.get_platform())
      filename = command.get_filename
      out = File.new(basepath+"/"+command.get_filename(),"w+")
					
      out.puts(command.get_codesnippet())
      out.close()
				
      id=command.get_id()
			exec = command.get_executor()
      value = command.get_value()
      
      part2 = "\{|i,o,t| if o.read.include?('"+value+"') "
      part2+= "then 'Test success:"+id+"' else 'Test failed:"+id+"' end \}\") "
      
      if(exec=="")
        mainline = "puts eval(\"Open3.popen2e('"+filename+"') "
      elsif(exec.include?("$.$-f-$.$"))
        execplus = exec.gsub("$.$-f-$.$",filename)
        mainline = "puts eval(\"Open3.popen2e('"+execplus+"') "
      else
        mainline = "puts eval(\"Open3.popen2e('"+exec+" "+filename+"') "
      end
      mainline+=part2
    end
    return mainline
  end
end
