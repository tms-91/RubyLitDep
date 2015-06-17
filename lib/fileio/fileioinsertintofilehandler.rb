require "fileio/fileiohandler"

class FileIOInsertIntoFileHandler < FileIOHandler

	def initialize(handler_for)
		super(handler_for)
	end

	def process_command(command,basepath,platform)
    filename="'"+command.get_filename+"'"
    line=command.get_line
    substitute=command.get_codesnippet

    substitute=substitute.gsub(/"/,"\\\"")

    substitute=substitute.gsub("\n",'\n')

    substitute="\""+substitute+"\""

    id=command.get_id

    return_hash = Hash.new()

    return_hash[:executor]="insertintofile(#{filename},#{line},#{substitute})"
    return_hash[:type]="fileop"

    return_hash[:id]=id
    return return_hash
	end

end
