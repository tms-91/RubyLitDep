# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class HTMLTransformer
  def pushexeclinks(runelements, htmlpath)
    htmlcontent = File.read(htmlpath)
    
    runelements.each { |runelement| 
      match = htmlcontent.match(/<!--""LDS.*#{runelement}.*/)
      buttontemplate = '</br><a style="text-decoration: none; background-color: #EEEEEE; color: #333333; padding: 2px 6px 2px 6px;  border-top: 1px solid #CCCCCC;  border-right: 1px solid #333333;  border-bottom: 1px solid #333333;  border-left: 1px solid #CCCCCC;" href="'+runelement+'">?Caption</a></br>'
      unless match==nil 
        #TODO: Add specific button labels for each cmd 
        if match.to_s.include?("DeclareVariables")
          htmlcontent.sub!(match.to_s, buttontemplate.sub('?Caption','Enter data') +match.to_s)
        elsif match.to_s.include?("RootFile")
          htmlcontent.sub!(match.to_s, buttontemplate.sub('?Caption','Execute script') +match.to_s)
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
