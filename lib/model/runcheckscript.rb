# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class RunCheckScript < RunScript
  def initialize(id,snippet, section, filename, platform, executor,varname)
    super(id,snippet, section, filename, platform, executor)
    @value = varname
  end
  
  def get_value
    @value
  end
end
