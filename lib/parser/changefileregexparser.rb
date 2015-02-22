# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require 'model/changefileregex'
require 'parser/blockparser'
class ChangeFileRegexParser < BlockParser
  
  def parse(lines,nr)
    cmdline = lines[nr]
    id = getattributevalue(cmdline, 'id')
    snippet = parseblock(lines, nr)
    filename = getattributevalue(cmdline, 'filename')
    regex = getattributevalue(cmdline, 'regex')
    return ChangeFileRegex.new(id, snippet, filename, regex)
  end
end
