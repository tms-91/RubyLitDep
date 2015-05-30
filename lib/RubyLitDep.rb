#GUI
require 'Qt4'
require 'qtwebkit'
#require './qwidget.rb'
#require './listmodel.rb'
require 'minigui/qwidget.rb'
require 'minigui/webview'
require 'minigui/minigui.rb'

#FileIO
require 'fileutils.rb'
Dir["fileio/*.rb"].each { |file| 
  rfile = file.sub!("lib/","")
  require rfile }


#Pipeline
Dir["pipeline/*.rb"].each { |file| 
  rfile = file.sub!("lib/","")
  require rfile }


#Model
Dir["model/*.rb"].each { |file| 
  rfile = file.sub!("lib/","")
  require rfile }

#modelworker
Dir["modelwork/*.rb"].each { |file| 
  rfile = file.sub!("lib/","")
  require rfile }
  
#Parser
Dir["parser/*.rb"].each { |file| 
  rfile = file.sub!("lib/","")
  require rfile }
