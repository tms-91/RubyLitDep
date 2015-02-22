# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require "model/command"


class DeleteFileLines < Command
  
  def initialize(name, sl, el)
    @filename = name
    @startline = sl
    @endline = el
  end
  
  def get_filename
    @filename
  end
  
  def get_startline
    @startline
  end
  
  def get_endline
    @endline
  end
end
