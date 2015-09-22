
require 'modelwork/modelworker.rb'

require 'model/blockcommand'
require 'model/command'
require 'model/changefilelines'
require 'model/changefileregex'
require 'model/reusefragment'
require 'model/extendscript'
require 'model/declarefragment'
require 'model/requestuserinput'
require 'model/deletefilelines'
require 'model/addfilecontent'
require 'model/runscript'

class ReuseFragmentResolver < ModelWorker
  
  def refine(manual)
    puts 'running ReuseFragmentResolver'
    #puts "resolving references in script"
    #alle BlockCommand ids speichern
    #in allen Blocks ReuseFragment ersetzen durch Blöcke mit entsprechender Id
    map = {}
    dellist = Array.new
    manual.get_commands.each { |cmd| 
      if cmd.is_a?(BlockCommand)
        id = cmd.get_id
        map[id]=cmd
      end
      if(cmd.is_a?(DeclareFragment)||cmd.is_a?(ReuseFragment))
        dellist.push(cmd)
      end
    }
    manual.get_commands.each { |cmd| 
      if cmd.is_a?(BlockCommand)
        snippet = cmd.get_fragment
        #puts cmd.get_id
        while(snippet.include?("<!--\"\"LDS BeginReuseFragment"))
          #puts "trying to resolve reference"
          cmdline = snippet.match('<!--\"\"LDS BeginReuseFragment id=\"([^\"])+\"').to_s
	  if cmdline==nil
		  raise 'ReuseFragment Error. Fragment: '+snippet
	  end
          match = cmdline.match('id=\"([^\"])+\"').to_s
	  if match==nil
		  raise 'ReuseFragment id Error. line: '+cmdline
	  end
          refid = match.split('=')[1].delete('\"').to_s
	  
          
          puts "trying to resolve reference "+refid+'\nFragment:\n'+snippet+'\n\n'
          referenced = map[refid]
          replacingtext = referenced.get_fragment
   
          regexstring = '<!--\"\"LDS BeginReuseFragment id=\"'+refid+'\".*?<!--\"\"LDS EndReuseFragment( )?(-->)?(<pre>)?( )*(<code>)?'
          regex = Regexp.new(regexstring, Regexp::MULTILINE)
          snippet.sub!(regex, replacingtext)
          snippet.strip!
          #puts snippet
        end
        cmd.set_fragment(snippet)
      end
    }
    dellist.each { |deletecmd| 
      manual.delete_command(deletecmd)
    }
    
    return manual
  end
end
