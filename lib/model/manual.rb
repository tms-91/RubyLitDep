# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class Manual
  
  def initialize
  	@commands=Array.new
  end
  
  def get_commands
    return @commands
  end
  
  def add_command(cmd)
    @commands.push(cmd)
    cmd.set_script(self)
  end
  
  def delete_command(cmd)
    @commands.delete(cmd)
  end
  
  def get_number_commands
    return @commands.length
  end
  
  def get_command_at(position)
    return @commands.at(position)
  end
end
