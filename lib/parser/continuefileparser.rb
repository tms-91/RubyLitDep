# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require 'parser/blockparser'
require 'model/continuefile'

class ContinueFileParser < BlockParser
  def parse(lines,nr)
    cmdline = lines[nr]
    id = getattributevalue(cmdline, 'id')
    snippet = parseblock(lines, nr)
    section = getattributevalue(cmdline, 'section')
    filename = getattributevalue(cmdline, 'filename')
    return ContinueFile.new(id, snippet, section, filename)
  end
end
