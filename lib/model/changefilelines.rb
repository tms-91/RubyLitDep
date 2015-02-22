# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require "model/block"

class ChangeFileLines < Block
  def initialize(id, snippet, filename, startline, endline)
    super(id, snippet)
    @fileName = filename
    @startLine = startline
    @endLine = endline
  end
  
  def get_filename
    @fileName
  end
  
  def get_startline
    @startLine
  end
  
  def get_endline
    @endLine
  end
end
