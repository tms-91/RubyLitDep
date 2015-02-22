require 'fileutils'
require 'date'

def changefilelines(filename,from,to,substitute)
	date = DateTime.now()
	filename_rand = filename+"."+date.year.to_s+"_"+date.month.to_s+"_"+date.day.to_s+"_"+date.hour.to_s+"_"+date.minute.to_s+"_"+date.second.to_s
	
	FileUtils.mv(filename,filename_rand)
	
	infile=File.new(filename_rand,"r")
	outfile=File.new(filename,"w+")
	readcount=0
	written=false
	
	while line=infile.gets
		if((readcount<from)||(readcount>=to))
			outfile.puts(line)
		elsif(!written)
			outfile.puts(substitute)
			written=true
		end
		readcount=readcount+1
	end
	
	if(!written)
		outfile.puts(substitute)
	end
	
	infile.close()
  FileUtils.remove_file(infile, true)
	outfile.close()
	
	
end
	
	
def changefileregex(filename,regex,substitute)
	date = DateTime.now()
	filename_rand = filename+"."+date.year.to_s+"_"+date.month.to_s+"_"+date.day.to_s+"_"+date.hour.to_s+"_"+date.minute.to_s+"_"+date.second.to_s
	
	FileUtils.mv(filename,filename_rand)
	
	regex_object=/#{regex}/
	infile=File.new(filename_rand,"r")
	outfile=File.new(filename,"w+")
	
	read=""
	
	while line=infile.gets
		read=read+line
	end
  
	read=read.gsub(regex_object,substitute)
  
	outfile.puts(read)
	
  #Change
	infile.close()
  FileUtils.remove_file(infile, true)
	outfile.close()
	
end	

def deletefilelines(filename,from,to)
	changefilelines(filename,from,to,"")
end

def insertintofile(filename,at_line,substitute)
	if(File.exists?(filename))
		date = DateTime.now()
		filename_rand = filename+"."+date.year.to_s+"_"+date.month.to_s+"_"+date.day.to_s+"_"+date.hour.to_s+"_"+date.minute.to_s+"_"+date.second.to_s
		
		FileUtils.mv(filename,filename_rand)
		
		infile=File.new(filename_rand,"r")
		outfile=File.new(filename,"w+")
		readcount=0
		written=false
		
		while line=infile.gets
			if(readcount==at_line)
				outfile.puts(substitute)
			end
			readcount=readcount+1
			outfile.puts(line)
		end
		
		
		infile.close()
    FileUtils.remove_file(infile, true)
		outfile.close()
	
	else 
		outfile=File.new(filename,"w+")
		at_line.times {outfile.puts("\n")}
		outfile.puts(substitute)
		outfile.close
	end
	
	
	
end
