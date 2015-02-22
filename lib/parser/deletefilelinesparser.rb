# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require 'model/deletefilelines'
require 'parser/commandparser'

class DeleteFileLinesParser < CommandParser
  def parse(lines,nr)
    cmdline = lines[nr]
    filename = getattributevalue(cmdline, 'filename')
    startline = getattributevalue(cmdline, 'startline')
    endline = getattributevalue(cmdline, 'endline')
    return DeleteFileLines.new(filename, startline, endline)
  end
end
