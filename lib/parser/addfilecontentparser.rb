# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require 'model/addfilecontent'
require 'parser/blockcommandparser'

class AddFileContentParser < BlockCommandParser
  def parse(lines,nr)
    cmdline = lines[nr]
    id = getattributevalue(cmdline, 'id')
    snippet = parseblock(lines, nr)
    filename = getattributevalue(cmdline, 'filename')
    line = getattributevalue(cmdline, 'line')
    return AddFileContent.new(id, snippet,filename, line)
  end
end
