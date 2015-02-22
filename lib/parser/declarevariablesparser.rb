# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require 'parser/commandparser'
require 'model/declarevariables'

class DeclareVariablesParser < CommandParser
  def parse(lines,nr)
    cmdline = lines[nr]
    vars = Array.new
    varsstring = getattributevalue(cmdline, 'variables')
    varsstring.split(",").each { |var| vars.push(var) }
    return DeclareVariables.new(vars)
  end
end
