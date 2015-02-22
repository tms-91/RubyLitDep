# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require "model/command"

class Block < Command
  def initialize(id, snippet)
    @id = id
    @codeSnippet = snippet
  end
  
  def get_id
    @id
  end
  
  def get_codesnippet
    @codeSnippet
  end
  
  def set_codesnippet text
    @codeSnippet = text
  end
  
end
