# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require 'parser/commandparser'
require 'model/reusefragment'

class ReuseFragmentParser < CommandParser
  def parse(lines,nr)
    cmdline = lines[nr]
    refid = getattributevalue(cmdline, 'id')
    return ReuseFragment.new(refid)
  end
end
