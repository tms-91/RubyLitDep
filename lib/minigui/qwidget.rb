require 'Qt4'

class QWidget
	def initialize

	end
  
	def get_value(widget, memo) # given = widget & memo = printed text
		text = Qt::InputDialog.getText(widget, "Input Dialog", memo)
		return text
	end

	def get_path(given, memo) # given = widget & memo = printed text
		file = Qt::FileDialog.new
		text = file.getExistingDirectory given, memo
		puts text
		return text
	end

	def get_file(given, memo) # given = widget & memo = printed text
		file = Qt::FileDialog.new
		text = file.getOpenFileName given, memo
		return text
	end

	def show_alert(given, memo)
		Qt::MessageBox.critical given, "Error", memo
	end
end