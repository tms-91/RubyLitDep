
require 'modelwork/modelworker.rb'

class Codereferenceresolver < ModelWorker
  
  def refine(script)
    puts "resolving references in script"
    #alle Block ids speichern
    #in allen Blocks CodeReference ersetzen durch Blöcke mit entsprechender Id
    map = {}
    dellist = Array.new
    script.get_commands.each { |cmd| 
      if cmd.is_a?(Block)
        id = cmd.get_id
        map[id]=cmd
      end
      if(cmd.is_a?(DeclareReference)||cmd.is_a?(CodeReference))
        dellist.push(cmd)
      end
    }
    script.get_commands.each { |cmd| 
      if cmd.is_a?(Block)
        snippet = cmd.get_codesnippet
        puts cmd.get_id
        while(snippet.include?("<!--\"\"LDS BeginCodeReference"))
          puts "trying to resolve reference"
          cmdline = snippet.match('<!--\"\"LDS BeginCodeReference id=\"([^\"])+\"').to_s
          match = cmdline.match('id=\"([^\"])+\"').to_s
          refid = match.split('=')[1].delete('\"').to_s
          referenced = map[refid]
          replacingtext = referenced.get_codesnippet
   
          regexstring = '<!--\"\"LDS BeginCodeReference id=\"([^\"])+\".*<!--\"\"LDS EndCodeReference(-->)?'
          regex = Regexp.new(regexstring, Regexp::MULTILINE)
          snippet.sub!(regex, replacingtext)
          
          puts snippet
        end
        cmd.set_codesnippet(snippet)
      end
    }
    dellist.each { |deletecmd| 
      script.delete_command(deletecmd)
    }
    
    return script
  end
end
