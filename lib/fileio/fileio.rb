require "model/script"
require "model/command"


require "fileio/fileiohandler"
require "fileio/fileiohandlerregistry"

require 'fileutils'


class FileIO < Object

	@handler_registry = nil
	@written_files=nil

	def initialize
		@handler_registry = FileIOHandlerRegistry.new

		@written_files=Array.new()

	end

	def add_command_handler(command_handler)
		@handler_registry.add_handler(command_handler)
	end

	def create_file(basepath,filename)

		if(basepath.is_a?(String))

			file=File.new(basepath+"/"+filename,"w+")
			return file
		else
			return nil
		end
	end

	def dispatch_io_operation(command,basepath,platform)

		if(!basepath.is_a?(String))
			return nil;
		end

		puts "Dispatching File"
		if(command.kind_of? Command)
			puts "Its a Command"
			puts "Its a "+command.class.to_s

			handler = @handler_registry.get_handler(command.class.to_s)

			return_hash = handler.process_command(command,basepath,platform)
			if((return_hash!=nil)&&(return_hash.kind_of?(Hash)))
				@written_files.push(return_hash)
			end


		end
	end

	def start_file_output(script,basepath, platform)
		if(!script.is_a?(Script))
			return nil

		end

		if(!basepath.is_a?(String))
			return nil
		end

		for command_index in (0...script.get_number_commands)
			command=script.get_command_at(command_index)

			puts "Dispatching command "+command_index.to_s
			self.dispatch_io_operation(command,basepath,platform)

		end
		self.output_mainfile(basepath)
	end

	def output_mainfile(basepath)

		#FileUtils.cp("fileio/filefunctions.rb",basepath+"/filefunctions.rb")
		file=self.create_file(basepath,"main.rb")
		puts("Writing main File")

		for i in (0...@written_files.length)
			main_command=@written_files.at(i)
			puts i.to_s+" "+main_command.to_s
			if(main_command[:executor]!=nil)
				if((main_command[:type]==="execute"))
					if((main_command[:executor]===""))
						file.puts("system('"+main_command[:filename]+"')"+"\t#"+main_command[:id])
					elsif((main_command[:executor].include? "$.$-f-$.$"))
						#using ruby's system-method
						merged_executor=main_command[:executor].gsub("$.$-f-$.$",main_command[:filename])
						file.puts("system('"+merged_executor+"')"+"\t#"+main_command[:id])
					else
						#using ruby's system-method
						file.puts("system('"+main_command[:executor]+" "+main_command[:filename]+"')"+"\t#"+main_command[:id])
					end
				elsif((main_command[:type]==="fileop"))
					if(main_command[:id]!=nil)
						file.puts(main_command[:executor]+"\t#"+main_command[:id])
					else
						file.puts(main_command[:executor])
					end
				elsif((main_command[:type]==="varOp"))
					file.puts(main_command[:executor])
        elsif((main_command[:type]=="dataFlow"))
          if((main_command[:executor]===""))
						file.puts("Open3.popen2e('"+main_command[:filename]+"') \{|i,o,t| replacevariable('"+basepath+"','"+main_command[:var]+"',o.read) \}"+"\t#"+main_command[:id])
					elsif((main_command[:executor].include? "$.$-f-$.$"))

						merged_executor=main_command[:executor].gsub("$.$-f-$.$",main_command[:filename])
						file.puts("Open3.popen2e('"+merged_executor+"') \{|i,o,t| replacevariable('"+basepath+"','"+main_command[:var]+"',o.read) \} \t#"+main_command[:id])
					else
						#using ruby's system-method
						file.puts("Open3.popen2e('"+main_command[:executor]+" "+main_command[:filename]+"') \{|i,o,t| replacevariable('"+basepath+"','"+main_command[:var]+"',o.read) \} \t#"+main_command[:id])
					end
        elsif((main_command[:type]=="constraint"))
          if((main_command[:executor]===""))
						file.puts("puts eval(\"Open3.popen2e('"+main_command[:filename]+"') \{|i,o,t| if o.read.include?('"+main_command[:value]+"') then 'Test success:"+main_command[:id]+"' else 'Test failed:"+main_command[:id]+"' end \}\") ")
					elsif((main_command[:executor].include? "$.$-f-$.$"))

						merged_executor=main_command[:executor].gsub("$.$-f-$.$",main_command[:filename])
						file.puts("puts eval(\"Open3.popen2e('"+merged_executor+"') \{|i,o,t| if o.read.include?('"+main_command[:value]+"') then 'Test success:"+main_command[:id]+"' else 'Test failed:"+main_command[:id]+"' end \}\") ")
					else
						#using ruby's system-method
						file.puts("puts eval(\"Open3.popen2e('"+main_command[:executor]+" "+main_command[:filename]+"') \{|i,o,t| if o.read.include?('"+main_command[:value]+"') then 'Test success:"+main_command[:id]+"' else 'Test failed:"+main_command[:id]+"' end \}\") ")
					end
        end
			end
		end
		file.close()

	end


end


