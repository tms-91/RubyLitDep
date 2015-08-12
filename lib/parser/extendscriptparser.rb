# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require 'parser/blockcommandparser'
require 'model/extendscript'

class ExtendScriptParser < BlockCommandParser
  def parse(lines,nr)
    cmdline = lines[nr]
    id = getattributevalue(cmdline, 'id')
    snippet = parseblock(lines, nr)
    section = getattributevalue(cmdline, 'section')
    filename = getattributevalue(cmdline, 'filename')
    return ExtendScript.new(id, snippet, section, filename)
  end
end
