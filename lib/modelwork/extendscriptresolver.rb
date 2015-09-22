
require 'modelwork/modelworker'

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
class ExtendScriptResolver < ModelWorker
  
  def refine(manual)
	  
    puts 'running ExtendScriptResolver'
    #search for all root- and continuefile-cmds
    #save them mapped to their filename
    map = {}
    manual.get_commands.each do |cmd|  
      if cmd.is_a?(RunScript) or cmd.instance_of?(ExtendScript)
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
      fragment=''
      array.each { |cmd| 
        if cmd.is_a?(RunScript)
          root = cmd
          fragment+= cmd.get_fragment
        elsif cmd.nil?
          manual.delete_command(cmd)
        else
          fragment+=cmd.get_fragment
          #remove continuefiles from script
          manual.delete_command(cmd)
        end
      }
      root.set_fragment(fragment)
    end
    
    return manual
  end
  
end
