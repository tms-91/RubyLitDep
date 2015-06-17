#GUI
require 'Qt4'
require 'qtwebkit'
require 'open3'
#require './qwidget.rb'
#require './listmodel.rb'
require 'minigui/qwidget.rb'
require 'minigui/webview'
require 'minigui/minigui.rb'

#FileIO
require 'fileutils.rb'
Dir["fileio/*.rb"].each { |file| 
  rfile = file.sub!("lib/","")
  require file }


#Pipeline
Dir["pipeline/*.rb"].each { |file| 
  rfile = file.sub!("lib/","")
  require file }


#Model
Dir["model/*.rb"].each { |file| 
  rfile = file.sub!("lib/","")
  require file }

#modelworker
Dir["modelwork/*.rb"].each { |file| 
  rfile = file.sub!("lib/","")
  require file }
  
#Parser
Dir["parser/*.rb"].each { |file| 
  rfile = file.sub!("lib/","")
  require file }
