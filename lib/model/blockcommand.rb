# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require "model/command"

class BlockCommand < Command
  def initialize(id, fragment)
    @id = id
    @fragment = fragment
  end
  
  def get_id
    @id
  end
  
  def get_fragment
    @fragment
  end
  
  def set_fragment text
    @fragment = text
  end
  
end
