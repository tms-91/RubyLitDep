require "model/script"
require "model/command"


require "fileio/fileiohandler"
require "fileio/fileiohandlerregistry"

require 'fileutils'


class FileIO

	def initialize
		@handler_registry = FileIOHandlerRegistry.new
	end

	def add_command_handler(command_handler)
		@handler_registry.add_handler(command_handler)
	end

	def start_file_output(script,basepath, platform)
    
		if(!script.is_a?(Script)||!basepath.is_a?(String))
			return nil
		end
    mainfile = File.new(basepath+"/main.rb","w+")
    puts "Starting file output"
    script.get_commands.each { |command|
      puts "Creating output for "+command.class.to_s
      
      handler = @handler_registry.get_handler(command.class.to_s)
      mainfile.puts(handler.compute_mainline(command, basepath, platform)+"\n")
      
      puts handler.compute_mainline(command, basepath, platform)
    }
    mainfile.close()
	end

end


