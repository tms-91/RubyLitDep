# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require 'model/insertintofile'
require 'parser/blockparser'

class InsertIntoFileParser < BlockParser
  def parse(lines,nr)
    cmdline = lines[nr]
    id = getattributevalue(cmdline, 'id')
    snippet = parseblock(lines, nr)
    filename = getattributevalue(cmdline, 'filename')
    line = getattributevalue(cmdline, 'line')
    return InsertIntoFile.new(id, snippet,filename, line)
  end
end
