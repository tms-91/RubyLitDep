# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require "model/block"


class InsertIntoFile < Block
  def initialize(id, snippet, name, line)
    super(id, snippet)
    @fileName = name
    @line = line
  end
  
  def get_filename
    @fileName
  end
  
  def get_line
    @line
  end
end
