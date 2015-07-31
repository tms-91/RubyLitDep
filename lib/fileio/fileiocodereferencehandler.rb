require "fileio/fileiohandler"

class FileIOCodeReferenceHandler < FileIOHandler
	
	def initialize(handler_for)
		super(handler_for)
	end
  
  def compute_mainline(command, basepath, platform)
    raise "A CodeReuse should not be here"
		return nil
  end
	
end
