# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require "model/command"


class CodeReference < Command
  def initialize(id)
    @refID = id
  end
  
  def get_refid
    @refID
  end
end
