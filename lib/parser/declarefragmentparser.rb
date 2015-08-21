# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require 'model/declarefragment'

class DeclareFragmentParser < BlockCommandParser
  def parse(lines,nr)
    cmdline = lines[nr]
    id = getattributevalue(cmdline, 'id')
    snippet = parseblock(lines, nr)
    return DeclareFragment.new(id, snippet)
  end
end
