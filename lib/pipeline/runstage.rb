# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require 'fileio/filefunctions'
require 'open3'

class RunStage
  
  def run_file(runpath, widget)
    lines = File.readlines(runpath+'/main.rb')
    lines.each do |item| 
      if item.include?('#Variable')
        variables = item.split(':')[1].strip
        variables.split(',').each { |var| 
          value = QWidget.new.get_value(widget, var+' = ')
          if(value.nil?)
            return
          end
          value = value.to_s
          replacevariable(runpath,var,value)
        }
      else
        eval(item)
      end
    end
  end
  
  def run_singlecmd(runpath, name, widget)
    #puts name
    if name.include?("variables=")
      variables = name.split('=')[1].strip.gsub('"', '')
      name = "#Variable: "+variables
    end
    lines = File.readlines(runpath+'/main.rb')
    regex = /.*#{name}.*/
    lines.each { |line|  
      match = line.match(regex)
      unless match==nil
        if(match.to_s.include?('Variable'))
          variables = match.to_s.split(':')[1].strip
          variables = variables.gsub('"',"")
          variables.split(',').each { |var| 
            value = QWidget.new.get_value(widget, var+' = ')
            if(value.nil?)
              return
            end
            value = value.to_s
            replacevariable(runpath,var,value)
          }
        else
          eval(line)
        end
      end
    }
  end
  
  def run_lines(runpath, linenumbers, widget)
    lines = File.readlines(runpath+'/main.rb')
    linenumbers.each { |number| 
      
      item = lines[number]
      
      if item.include?('#Variable')
        variables = item.split(':')[1].strip
        variables.split(',').each { |var| 
          value = QWidget.new.get_value(widget, var+' = ')
          if(value.nil?)
            return
          end
          value = value.to_s
          replacevariable(runpath,var,value)
        }
      else
        eval(item)
      end
    }
  end
end
