# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class CommandParser
  
  def initialize(parser_for)
    @cmdname = parser_for
  end
  
  def get_parser_for
    return @cmdname
  end
  
  def getattributevalue(line, attributename)
    begin
      match = line.match(attributename+'=\"([^\"])+\"').to_s
      value = match.split('=')[1].delete('\"')
    rescue Exception=>e
      raise 'Parser Exception:'+attributename+'\n'+line
    end
    
    return value
  end
  
  def parse(lines, nr)
    puts "This is a default parser for line: "+nr+"! It does nothing."
  end
end
