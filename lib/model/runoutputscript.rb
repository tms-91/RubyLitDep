# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require "model/runscript"

class RunOutputScript < RunScript
  
  def initialize(id,snippet, section, filename, platform, executor)
    super(id,snippet, section, filename, platform, executor)
  end
  
end
