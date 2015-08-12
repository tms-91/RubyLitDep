# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require 'io/console'
require 'model/manual'
require 'parser/parserregistry'

Dir["lib/parser/*.rb"].each { |file| 
  parserfile = file.sub!("lib/","")
  require parserfile }

class ParserDispatcher
  
  def initialize
    @registry = Parserregistry.new
  end
  
  def register_parser(parser)
    @registry.add_parser(parser)
  end
  
  def parse(filepath)
    lines = File.readlines(filepath)
    script = Manual.new
    
    number = 0
    while number < lines.size do
      line = lines[number]
      if line.include?('<!--""LDS')
        cmd = line.split(' ')[1]
        
        if cmd.include?('Begin')
          cmd.sub!('Begin', '')
        end
        
        if cmd.include?('End')
          raise 'Error: End cmd found while parsing with ParserDispatcher'
        end
        
        #optimization point: create each parser object only once
        cmdparser = @registry.get_parser(cmd)
        
        #is_a? checks for being an instance of class or an instance of
        #a subclass. instance_of? only checks wether the object is an insance
        #of the exact class.
        unless cmdparser.is_a?(CommandParser)
          puts cmdparser.class.to_s
           raise 'Something went wrong in the dispatching process
           while trying to parse with parserclass:'+cmdparser.class.to_s 
        end
        
        
        cmdobject = cmdparser.parse(lines, number)
        script.add_command(cmdobject)
        if cmdparser.is_a?(BlockCommandParser)
          number = cmdparser.getlinenr
        else
          number+=1
        end
      else
        number+=1
      end
    end
    return script
  end
  
end
