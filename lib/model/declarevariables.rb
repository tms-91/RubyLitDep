# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require "model/command"


class DeclareVariables < Command
  
  def initialize (vars)
    @variables = vars
  end
  
  def get_variables
    @variables
  end
  
  def add_variable(var)
    @variables.add(var)
  end
  
  def remove_variable(var)
    @variables.remove(var)
  end
  
end
