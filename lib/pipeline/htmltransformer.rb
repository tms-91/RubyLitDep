# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class HTMLTransformer
  def pushexeclinks(runelements, htmlpath)
	  puts 'creating new html file with buttons'
    htmlcontent = File.read(htmlpath)
    
    runelements.each { |runelement| 
      match = htmlcontent.match(/<!--""LDS.*#{runelement}.*/)
      buttontemplate = '</br><a style="text-decoration: none; background-color: #EEEEEE; color: #333333; padding: 2px 6px 2px 6px;  border-top: 1px solid #CCCCCC;  border-right: 1px solid #333333;  border-bottom: 1px solid #333333;  border-left: 1px solid #CCCCCC;" href="'+runelement+'">?Caption</a></br>'
      unless match==nil 
        #TODO: Add specific button labels for each cmd 
	puts 'found: '+match.to_s
        if match.to_s.include?("RequestUserInput")
	  puts 'creating button: RequestUserInput'
          htmlcontent.sub!(match.to_s, buttontemplate.sub('?Caption','Specify input data') +match.to_s)
        elsif match.to_s.include?("RunOutputScript")
	  puts 'creating button: RunOutputScript'
          htmlcontent.sub!(match.to_s, buttontemplate.sub('?Caption','Execute script') +match.to_s)
        elsif match.to_s.include?("RunEffectScript")
	  puts 'creating button: RunEffectScript'
          htmlcontent.sub!(match.to_s, buttontemplate.sub('?Caption', 'Execute effect script') +match.to_s)
        elsif match.to_s.include?("AddFileContent")
	  puts 'creating button: AddFileContent'
          htmlcontent.sub!(match.to_s, buttontemplate.sub('?Caption','Insert content into file') +match.to_s)
        elsif match.to_s.include?("ChangeFile")
	  puts 'creating button: ChangeFile'
          htmlcontent.sub!(match.to_s, buttontemplate.sub('?Caption','Replace content in file') +match.to_s)
        elsif match.to_s.include?("RunCheckScript")
	  puts 'creating button: RunCheckScript'
          htmlcontent.sub!(match.to_s, buttontemplate.sub('?Caption','Test specified constraint') +match.to_s)
        elsif match.to_s.include?("DeleteFileLines")
	  puts 'creating button: DeleteFileLines'
          htmlcontent.sub!(match.to_s, buttontemplate.sub('?Caption','Remove content in file') +match.to_s)
        end
      else
        puts "Not Working:"+runelement
      end
    }
    newhtmlpath = htmlpath.sub(".html","executable.html")
    file = File.new(newhtmlpath,"w+")
    file.puts(htmlcontent)
    file.close
    
    return newhtmlpath
  end
end
