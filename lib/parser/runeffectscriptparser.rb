# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require 'parser/blockcommandparser'
require 'model/runeffectscript'

class RunEffectScriptParser < BlockCommandParser
  
  #Stub object einspeisen?
  def parse(lines,nr)
    cmdline = lines[nr]
    id = getattributevalue(cmdline, 'id')
    snippet = parseblock(lines, nr)
    section = getattributevalue(cmdline, 'section')
    filename = getattributevalue(cmdline, 'filename')
    platform = getattributevalue(cmdline, 'platform')
    executor = getattributevalue(cmdline, 'executor')
    varname = getattributevalue(cmdline,'varname')
    return RunEffectScript.new(id,snippet, section, filename, platform, executor,varname)
  end
end
