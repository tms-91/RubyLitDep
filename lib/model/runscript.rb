# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require "model/blockcommand"

class RunScript < BlockCommand
  def initialize(id,snippet, section, filename, platform, executor)
    super(id, snippet)
    @section = section
    @fileName = filename
    @platform = platform
    @executor = executor
  end
  
  def get_section
    @section
  end
  
  def get_filename
    @fileName
  end
  
  def get_platform
    @platform
  end
  
  def get_executor
    @executor
  end
end
