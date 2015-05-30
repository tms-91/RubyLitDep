
class Pipeline
  
  def initialize
    @parserdispatcher = ParserDispatcher.new
    @modelworkerdispatcher = ModelWorkerDispatcher.new
    @fileio = FileIO.new
  end
  
  def get_parserdispatcher
    return @parserdispatcher
  end
  
  def get_modelworkerdispatcher
    return @modelworkerdispatcher
  end
  
  def get_fileio
    return @fileio
  end
  
  def tangle(basepath, htmlpath, platform) 
    
    @parserdispatcher.register_parser(ChangeFileLinesParser.new("ChangeFileLines"))
    @parserdispatcher.register_parser(ChangeFileRegexParser.new("ChangeFileRegex"))
    @parserdispatcher.register_parser(CodeReferenceParser.new("CodeReference"))
    @parserdispatcher.register_parser(ContinueFileParser.new("ContinueFile"))
    @parserdispatcher.register_parser(DeclareReferenceParser.new("DeclareReference"))
    @parserdispatcher.register_parser(DeclareVariablesParser.new("DeclareVariables"))
    @parserdispatcher.register_parser(DeleteFileLinesParser.new("DeleteFileLines"))
    @parserdispatcher.register_parser(InsertIntoFileParser.new("InsertIntoFile"))
    @parserdispatcher.register_parser(RootFileParser.new("RootFile"))
    
    script = @parserdispatcher.parse(htmlpath)
    
    @modelworkerdispatcher.register_modelworker(Codereferenceresolver.new)
    @modelworkerdispatcher.register_modelworker(Continuefileresolver.new)
    script = @modelworkerdispatcher.refine(script)

    @fileio.add_command_handler(FileIOCodeReferenceHandler.new("CodeReference",platform))
    @fileio.add_command_handler(FileIORootFileHandler.new("RootFile",platform))
  	@fileio.add_command_handler(FileIOChangeFileLinesHandler.new("ChangeFileLines",platform))
  	@fileio.add_command_handler(FileIOChangeFileRegexHandler.new("ChangeFileRegex",platform))
   	@fileio.add_command_handler(FileIOContinueFileHandler.new("ContinueFile",platform))
  	@fileio.add_command_handler(FileIODeleteFileLinesHandler.new("DeleteFileLines",platform))
  	@fileio.add_command_handler(FileIOInsertIntoFileHandler.new("InsertIntoFile",platform))
  	@fileio.add_command_handler(FileIODeclareVariablesHandler.new("DeclareVariables",platform))
    @fileio.start_file_output(script, basepath)
    
    return declare_runelementstrings(script, platform)
  end
  
  def declare_runelementstrings (script, platform)
    runelements = Array.new
    script.get_commands.each { |cmd| 
      if cmd.is_a?(Block)
        if cmd.is_a?(RootFile)
          if cmd.get_platform == platform
            runelements.push(cmd.get_id)
          end
        else
          runelements.push(cmd.get_id)
        end
      end
      
      if cmd.is_a?(DeclareVariables)
        variables = cmd.get_variables.to_s
        variables = variables.gsub("[","")
        variables = variables.gsub("]","")
        runelements.push("variables="+variables)
      end
      
      if cmd.is_a?(DeleteFileLines)
        runelements.push("Deleting lines "+cmd.get_startline+" to "+cmd.get_endline+" in "+cmd.get_filename)
      end
    }
    return runelements
  end
  
  def pushexeclinks(runelements, htmlpath)
    htmlcontent = File.read(htmlpath)
    runelements.each { |runelement| 
      match = htmlcontent.match(/<!--""LDS.*#{runelement}.*/)
      
      unless match==nil 
        if match.to_s.include?("DeclareVariables")
          htmlcontent.sub!(match.to_s, "<a href='"+runelement+"'>Replace Variable</a></br>"+match.to_s)
        else
          htmlcontent.sub!(match.to_s, '<a href="'+runelement+'">Execute this</a></br>'+match.to_s)
        end
      else
        puts "Not Working:"+runelement
      end
    }
    newhtmlpath = htmlpath.sub(".html","executable.html")
    file = File.new(newhtmlpath,"w+")
    file.puts(htmlcontent)
    file.close
    
    return newhtmlpath
  end
  
  def run_file(runpath, widget)
    lines = File.readlines(runpath+'\\main.rb')
    lines.each do |item| 
      if item.include?('#Variable')
        variables = item.split(':')[1].strip
        variables.split(',').each { |var| 
          value = QWidget.new.get_value(widget, var+' = ')
          if(value.nil?)
            return
          end
          value = value.to_s
          Dir.foreach(runpath) do |file|
            next if file == '.' or file == '..' or File.directory?(file)
            # do work on real items
            puts file
            changefileregex(file,'\$.\$-'+var+'-\$.\$',value)
          end
        }
      else
        
        eval(item)
      end
    end
  end
  
  def run_singlecmd(runpath, name, widget)
    puts name+"moep"
    if name.include?("variables=")
      variables = name.split('=')[1].strip.gsub('"', '')
      name = "#Variable: "+variables
    end
    lines = File.readlines(runpath+'\\main.rb')
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
            Dir.foreach(runpath) do |file|
              next if file == '.' or file == '..'
              # do work on real items
              changefileregex(file,'\$.\$-'+var+'-\$.\$',value)
            end
          }
        else
          eval(line)
        end
      end
    }
  end
  
  def run_lines(runpath, linenumbers, widget)
    lines = File.readlines(runpath+'\\main.rb')
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
          Dir.foreach(runpath) do |file|
            next if file == '.' or file == '..'
            # do work on real items
            changefileregex(file,'\$.\$-'+var+'-\$.\$',value)
          end
        }
      else
        
        eval(item)
      end
    }
  end
  
end
