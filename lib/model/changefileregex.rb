# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require "model/blockcommand"


class ChangeFileRegex < BlockCommand
  def initialize(id, snippet, filename, regex)
    super(id, snippet)
    @fileName = filename
    @regEx = regex
  end
  
  def get_filename
    @fileName
  end
  
  def get_regex
    @regEx
  end
end
