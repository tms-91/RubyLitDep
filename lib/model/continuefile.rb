# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require "model/block"


class ContinueFile < Block
  def initialize(id, snippet, section, filename)
    super(id, snippet)
    @section = section
    @fileName = filename
  end
  
  def get_section
    @section
  end
  
  def get_filename
    @fileName
  end
end
