# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require 'model/runoutputscript'
require 'parser/blockcommandparser'

class RunOutputScriptParser < BlockCommandParser
  
  def parse(lines,nr)
    cmdline = lines[nr]
    id = getattributevalue(cmdline, 'id')
    snippet = parseblock(lines, nr)
    section = getattributevalue(cmdline, 'section')
    filename = getattributevalue(cmdline, 'filename')
    platform = getattributevalue(cmdline, 'platform')
    executor = getattributevalue(cmdline, 'executor')
    return RunOutputScript.new(id, snippet, section, filename, platform, executor)
  end
end
