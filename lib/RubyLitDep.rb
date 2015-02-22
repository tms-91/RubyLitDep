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
Dir["lib/fileio/*.rb"].each { |file| 
  rfile = file.sub!("lib/","")
  require rfile }


#Pipeline
Dir["lib/pipeline/*.rb"].each { |file| 
  rfile = file.sub!("lib/","")
  require rfile }


#Model
Dir["lib/model/*.rb"].each { |file| 
  rfile = file.sub!("lib/","")
  require rfile }

#modelworker
Dir["lib/modelwork/*.rb"].each { |file| 
  rfile = file.sub!("lib/","")
  require rfile }
  
#Parser
Dir["lib/parser/*.rb"].each { |file| 
  rfile = file.sub!("lib/","")
  require rfile }