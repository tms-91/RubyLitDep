
require 'modelwork/modelworker.rb'

require 'model/block'
require 'model/command'
require 'model/changefilelines'
require 'model/changefileregex'
require 'model/codereference'
require 'model/continuefile'
require 'model/declarereference'
require 'model/declarevariables'
require 'model/deletefilelines'
require 'model/insertintofile'
require 'model/rootfile'
class Continuefileresolver < ModelWorker
  
  def refine(script)
    #search for all root- and continuefile-cmds
    #save them mapped to their filename
    map = {}
    script.get_commands.each do |cmd|  
      if cmd.instance_of?(RootFile) or cmd.instance_of?(ContinueFile)
        filename = cmd.get_filename
        if map.has_key?(filename)
          map[filename].insert(cmd.get_section.to_i-1, cmd)
        else
          array = Array.new 
          array.insert(cmd.get_section.to_i-1, cmd)
          map[filename]=array
        end
      end
    end
    
    #combine snippets in rootfile
    
    map.each do |filename,array| 
      #find the rootfile
      root = nil
      snippet=''
      array.each { |cmd| 
        if cmd.instance_of?(RootFile)
          root = cmd
          snippet+= cmd.get_codesnippet
        else
          snippet+=cmd.get_codesnippet
          #remove continuefiles from script
          script.delete_command(cmd)
        end
      }
      root.set_codesnippet(snippet)
    end
    
    return script
  end
  
end
