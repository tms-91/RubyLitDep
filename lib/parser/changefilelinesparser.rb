# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require 'parser/blockparser'
require 'model/changefilelines'

class ChangeFileLinesParser < BlockParser
  def parse(lines,nr)
    cmdline = lines[nr]
    id = getattributevalue(cmdline, 'id')
    snippet = parseblock(lines, nr)
    filename = getattributevalue(cmdline, 'filename')
    startline = getattributevalue(cmdline, 'startline')
    endline = getattributevalue(cmdline, 'endline')
    return ChangeFileLines.new(id, snippet, filename, startline, endline)
  end
end
