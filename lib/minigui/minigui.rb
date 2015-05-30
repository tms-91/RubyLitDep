require 'pipeline/pipeline'

class Minigui < Qt::Widget
	slots 'comboitem(int)', 'basepathclicked()', 'tanglepathclicked()', 'starttangleclicked()', 'runbuttonclicked()', 'startsingleclicked()'

	def initialize()
		super()

		# prepare strings
		@htmlpathstring = ""
		@basepathstring = ""
		@runpathstring = ""
		@platformstring = "WINDOWS"

		# set window title
		self.window_title = 'Literate Deployment Scripting'

		# Global attributes to ride sided elements
		@listview = Qt::ListView.new
		@runbutton = Qt::PushButton.new ("Run files")
		@startsingle = Qt::PushButton.new("Start selected")

		# line three
		@webkit = MyWebView.new(self)

		# line one
		@combo = Qt::ComboBox.new
		@basepath = Qt:: PushButton.new('Select HTML file')
		@basepathlabel = Qt::LineEdit.new "Path selected", self

		# line two
		@tanglepath = Qt::PushButton.new("Select Path")
		@tanglepathlabel = Qt::LineEdit.new "No Path selected", self
		@starttangle = Qt::PushButton.new("Start Tangle")

		# define layout handling
		vbox = Qt::VBoxLayout.new
		vbox.addLayout generateLineOne()
		vbox.addLayout generateLineTwo()
		vbox.addWidget @webkit

		# general layout
		basebox = Qt::HBoxLayout.new self
		basebox.addLayout(vbox, 1)
		basebox.addLayout(generateListView)

		# set layout
		self.layout = basebox
	end

	def comboitem(item)
		@platformstring = @combo.currentText
		puts @combo.currentText
	end

	def basepathclicked()
		widget = QWidget.new

		text = widget.get_file(self, "Select Path to HTML file")

		if text != nil
			path = text.strip
			if not path.empty?
				@tanglepath.setEnabled true
				@basepathlabel.setText path
				@htmlpathstring = path
				@webkit.load(Qt::Url.new(path))
			end
		end
	end

	def generateLineOne()
		vbox = Qt::VBoxLayout.new
		label = Qt::Label.new('<big>Select your System and Filepath</big>')
		vbox.addWidget label

		hbox = Qt::HBoxLayout.new
		@combo.addItem "WINDOWS"
		@combo.addItem "UNIX"
		connect(@combo, SIGNAL('activated(int)'), self, SLOT('comboitem(int)'))
		hbox.addWidget @combo

		connect(@basepath, SIGNAL('clicked()'), self, SLOT('basepathclicked()'))
		hbox.addWidget @basepath

		@basepathlabel.setReadOnly(true)
		hbox.addWidget @basepathlabel

		vbox.addLayout hbox
		return vbox
	end

	def tanglepathclicked()
		widget = QWidget.new
		text = widget.get_path(self, "Select Path to write tangled files to")
		if(text != nil)
			path = text.strip
			if not path.empty?
				@tanglepathlabel.setText path
				@runpathstring = path
				@basepathstring = path
				@starttangle.setEnabled true
			end
		end
	end

	#tangle html file// load elements for listview// load new url (loadWebPage(urlstring))
	def starttangleclicked()
		@runbutton.setEnabled true
		@startsingle.setEnabled true
    pipeline = ::Pipeline.new
		runelements = pipeline.tangle(@basepathstring,@htmlpathstring,@platformstring)
    slmodel = Qt::StringListModel.new;
    slmodel.setStringList(runelements);
    #items = MyModel.new(runelements)
    @listview.model = slmodel
    newhtmlpath = pipeline.pushexeclinks(runelements, @htmlpathstring)
    loadWebPage(newhtmlpath)
	end

	def generateLineTwo()
		vbox = Qt::VBoxLayout.new
		label = Qt::Label.new('<big>Select the path to tangle your file to</big>')
		vbox.addWidget label

		hbox = Qt::HBoxLayout.new

		connect(@tanglepath, SIGNAL('clicked()'), self, SLOT('tanglepathclicked()'))
		@tanglepath.setEnabled false
		hbox.addWidget @tanglepath

		@tanglepathlabel.setReadOnly(true)
		hbox.addWidget @tanglepathlabel

		connect(@starttangle, SIGNAL('clicked()'), self, SLOT('starttangleclicked()'))
		@starttangle.setEnabled false
		hbox.addWidget @starttangle

		vbox.addLayout hbox
		return vbox
	end

	# execute all files
	def runbuttonclicked()
		FileUtils.cd(@basepathstring) do  # chdir
      begin
        ::Pipeline.new.run_file(@runpathstring, self)
      rescue => e
        puts e.message
        puts e.backtrace
        QWidget.new.show_alert(self, "An Error happened during execution")
      end
    end
	end

	# execute selected
	def startsingleclicked()
    #build array and fill row index
    linenumbers = Array.new
    @listview.selectionModel.selectedIndexes.each { |index|
      linenumbers.push(index.row)
    }
    #NEW
    #if only one element is selected this automatically switches
    #selection to the next element
    if linenumbers.size == 1
      curIndex = @listview.currentIndex
      @listview.selectionModel.setCurrentIndex(curIndex.sibling(curIndex.row+1, 0), Qt::ItemSelectionModel::ClearAndSelect)
    end

    #execute selected lines
    FileUtils.cd(@runpathstring) do
      begin
        ::Pipeline.new.run_lines(@runpathstring, linenumbers, self)
      rescue => e
        puts e.message
        puts e.backtrace
        QWidget.new.show_alert(self, "An Error happened during execution")
      end
    end
	end

	def generateListView()
    puts "Generating listview"
		#ListView
	    @listview.dragEnabled = false
	    @listview.spacing = 10
	    @listview.setSelectionMode(Qt::AbstractItemView::ExtendedSelection);
	  #movement snap activates drag and drop. By dropping an item, the item
    #is copied at the placed it's dropped at.
    #@listview.movement = Qt::ListView::Snap
	    @listview.acceptDrops = false
	    @listview.dropIndicatorShown = false
    slmodel = Qt::StringListModel.new;
    slmodel.setStringList([]);
    #items = MyModel.new()
    @listview.model = slmodel



	    #start all files
	    connect(@runbutton, SIGNAL('clicked()'), self, SLOT('runbuttonclicked()'))
		@runbutton.setEnabled false

		#start all selected files
		connect(@startsingle, SIGNAL('clicked()'), self, SLOT('startsingleclicked()'))
		@startsingle.setEnabled false

		sidebar = Qt::VBoxLayout.new
		sidebar.addWidget @listview
		sidebar.addWidget @startsingle
		sidebar.addWidget @runbutton
		return sidebar
	end

	def loadWebPage(urlstring)
		@webkit.load(Qt::Url.new(urlstring))
	end

  def get_basepathstring
    return @basepathstring
  end

end
