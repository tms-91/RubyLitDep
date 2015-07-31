require "fileio/fileiohandler"

class FileIODeclareReferenceHandler < FileIOHandler
	
	def initialize(handler_for)
		super(handler_for)
	end
  
  def compute_mainline(command, basepath, platform)
    raise "A DeclareFragment should not be here"
		return nil
  end
	
end
