# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class Command
  
  def initialize
    raise 'Doh! You are trying to instantiate an abstract class!'
  end
  
  def get_script
    @script
  end
  
  def set_script(scr)
    @script = scr
  end
  

end
