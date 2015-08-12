# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require 'parser/commandparser'
class BlockCommandParser < CommandParser
  
  def parseblock (lines, nr)
    snippet =''
    @counter = nr + 1
    cmdname = self.class.to_s.sub('Parser', '')
    currentline = lines[@counter]
    
    #adds each line in between begincmd and endcmd to snippet
    while !currentline.include?('<!--""LDS End'+cmdname)
      snippet+=currentline
      
      @counter +=1
      currentline = lines[@counter]
    end
    
    #Since we don't want to be at the EndCmd line, but one line ahead.
    @counter+=1
    
    return snippet
  end
  
  def getlinenr
    @counter
  end
  
end
