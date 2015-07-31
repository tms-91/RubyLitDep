require "fileio/fileiohandler"

class FileIOContinueFileHandler < FileIOHandler

	def initialize(handler_for)
		super(handler_for)
	end
	
  def compute_mainline(command, basepath, platform)
    raise "A ScriptSegment should not be here"
		return nil
  end
  
end
