class MyWebView < Qt::Widget
  signals 'linkClicked(QUrl)'
  slots 'linkClicked(QUrl)'

  def initialize(minigui)
    super()
    @minigui = minigui
    @webkit = Qt::WebView.new(self) 
    @webkit.page.linkDelegationPolicy = Qt::WebPage::DelegateAllLinks

    connect(@webkit, SIGNAL('linkClicked(QUrl)'), self, SLOT('linkClicked(QUrl)'))

    layout = Qt::VBoxLayout.new()
    layout.addWidget(@webkit)
    setLayout(layout)
  end
  
  # TODO execute links
  def linkClicked(url)
    puts url.path
    id = url.path.split('/').last
    puts id
		FileUtils.cd(@minigui.get_basepathstring) do  # chdir
      begin
        Pipeline.new.run_singlecmd(@minigui.get_basepathstring, id, @minigui)
      rescue => e
        puts e.message
        puts e.backtrace
        QWidget.new.show_alert(@minigui, "An Error happened during execution")
      end
    end
    
  end

  def load(file)
    @webkit.load(file)
  end

end
