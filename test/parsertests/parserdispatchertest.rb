# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'

#Parser
Dir["parser/*.rb"].each { |file| 
  #rfile = file.sub!("lib/","")
  require file }
#Model
Dir["model/*.rb"].each { |file| 
  #rfile = file.sub!("lib/","")
  require file }


# This test focuses on a single particular showcase
class ParserDispatcherTest < Test::Unit::TestCase
  
  def setup
    parserdispatcher = ParserDispatcher.new
    parserdispatcher.register_parser(ChangeFileLinesParser.new("ChangeFileLines"))
    parserdispatcher.register_parser(ChangeFileRegexParser.new("ChangeFileRegex"))
    parserdispatcher.register_parser(CodeReferenceParser.new("CodeReference"))
    parserdispatcher.register_parser(ContinueFileParser.new("ContinueFile"))
    parserdispatcher.register_parser(DeclareReferenceParser.new("DeclareReference"))
    parserdispatcher.register_parser(DeclareVariablesParser.new("DeclareVariables"))
    parserdispatcher.register_parser(DeleteFileLinesParser.new("DeleteFileLines"))
    parserdispatcher.register_parser(InsertIntoFileParser.new("InsertIntoFile"))
    parserdispatcher.register_parser(RootFileParser.new("RootFile"))
    @script = parserdispatcher.parse("../showcases/testshowcases/webserver.html")
  end
  
  def test_cmdcount
    #TODO: Write test
    assert_equal(22, @script.get_number_commands())
    # assert_equal("foo", bar)
  end
  
  # see line 26 in webserver.html
  def test_declarevariables1
    assert_instance_of(DeclareVariables, @script.get_command_at(0))
    dv = @script.get_command_at(0)
    assert_equal(1, dv.get_variables().size)
    assert(dv.get_variables[0].include?('password'))
  end
  
  # see line 27-29
  def test_beginfile1
    assert_instance_of(RootFile, @script.get_command_at(1))
    bf = @script.get_command_at(1)
    
    assert_equal('1', bf.get_section)
    assert_equal('passwd.sh', bf.get_filename)
    assert_equal('change password', bf.get_id)
    assert_equal('UNIX', bf.get_platform)
    assert_equal('sh', bf.get_executor)
    
    text = bf.get_codesnippet
    text.strip!
    expected = "passwd pi\n$.$-password-$.$"
    assert_equal(expected, text)
  end
  
  # see line 37-41
  def test_beginfile2
    assert_instance_of(RootFile, @script.get_command_at(2))
    bf = @script.get_command_at(2)
    
    assert_equal('1', bf.get_section)
    assert_equal('updateclock.sh', bf.get_filename)
    assert_equal('update clock', bf.get_id)
    assert_equal('UNIX', bf.get_platform)
    assert_equal('sh', bf.get_executor)
    
    text = bf.get_codesnippet
    text.strip!
    expected = "sudo dpkg-reconfigure tzdata\nsudo apt-get update\nsudo apt-get upgrade"
    assert_equal(expected, text)
  end
  
  # see line 43 45
  def test_beginfile3
    assert_instance_of(RootFile, @script.get_command_at(3))
    bf = @script.get_command_at(3)
    
    assert_equal('1', bf.get_section)
    assert_equal('setdate.sh', bf.get_filename)
    assert_equal('set date', bf.get_id)
    assert_equal('UNIX', bf.get_platform)
    assert_equal('sh', bf.get_executor)
    
    text = bf.get_codesnippet
    text.strip!
    expected = "sudo date --set=\"30 December 2013 10:00:00\""
    assert_equal(expected, text)
  end
  
  # see line 47-53
  def test_beginfile4
    assert_instance_of(RootFile, @script.get_command_at(4))
    bf = @script.get_command_at(4)
    
    assert_equal('1', bf.get_section)
    assert_equal('firmwareupdate.sh', bf.get_filename)
    assert_equal('update firmware', bf.get_id)
    assert_equal('UNIX', bf.get_platform)
    assert_equal('sh', bf.get_executor)
    
    text = bf.get_codesnippet
    text.strip!
    expected = "sudo apt-get install ca-certificates\n"+
				"sudo apt-get install git-core\n"+
				"sudo wget https://raw.github.com/Hexxeh/rpi-update/master/rpi-update  -O /usr/bin/rpi-update && sudo chmod +x /usr/bin/rpi-update\n"+
				"sudo rpi-update\n"+
				"sudo shutdown -r now"
    assert_equal(expected, text)
  end
  
  # see line 60 - 62
  def test_beginfile5
    assert_instance_of(RootFile, @script.get_command_at(5))
    bf = @script.get_command_at(5)
    
    assert_equal('1', bf.get_section)
    assert_equal('shownetwork.sh', bf.get_filename)
    assert_equal('shownetwork', bf.get_id)
    assert_equal('UNIX', bf.get_platform)
    assert_equal('sh', bf.get_executor)
    
    text = bf.get_codesnippet
    text.strip!
    expected = "ifconfig"
    assert_equal(expected, text)
  end
  
  # see line 65 - 69
  def test_beginfile6
    assert_instance_of(RootFile, @script.get_command_at(6))
    bf = @script.get_command_at(6)
    
    assert_equal('1', bf.get_section)
    assert_equal('installssh.sh', bf.get_filename)
    assert_equal('install ssh', bf.get_id)
    assert_equal('UNIX', bf.get_platform)
    assert_equal('sh', bf.get_executor)
    
    text = bf.get_codesnippet
    text.strip!
    expected = "sudo apt-get install ssh\nsudo /etc/init.d/ssh start\nsudo shutdown -r now"
    assert_equal(expected, text)
  end
  
  # see line 81 - 85
  def test_beginfile7
    assert_instance_of(RootFile, @script.get_command_at(7))
    bf = @script.get_command_at(7)
    
    assert_equal('1', bf.get_section)
    assert_equal('installapache.sh', bf.get_filename)
    assert_equal('install apache', bf.get_id)
    assert_equal('UNIX', bf.get_platform)
    assert_equal('sh', bf.get_executor)
    
    text = bf.get_codesnippet
    text.strip!
    expected = "sudo apt-get update\nsudo apt-get install apache2\nsudo service apache2 restart"
    assert_equal(expected, text)
  end
  
  # see line 94 - 96
  def test_beginfile8
    assert_instance_of(RootFile, @script.get_command_at(8))
    bf = @script.get_command_at(8)
    
    assert_equal('1', bf.get_section)
    assert_equal('installphp.sh', bf.get_filename)
    assert_equal('install php', bf.get_id)
    assert_equal('UNIX', bf.get_platform)
    assert_equal('sh', bf.get_executor)
    
    text = bf.get_codesnippet
    text.strip!
    expected = "sudo apt-get install php5"
    assert_equal(expected, text)
  end
  
  # see line 98 - 101
  def test_beginfile9
    assert_instance_of(RootFile, @script.get_command_at(9))
    bf = @script.get_command_at(9)
    
    assert_equal('1', bf.get_section)
    assert_equal('generatephpinfo.sh', bf.get_filename)
    assert_equal('generate php info file', bf.get_id)
    assert_equal('UNIX', bf.get_platform)
    assert_equal('sh', bf.get_executor)
    
    text = bf.get_codesnippet
    text.strip!
    expected = "cd /var/www\nsudo touch phpinfo.php"
    assert_equal(expected, text)
  end
  
  # see line 102 - 104
  def test_insertintofile1
    assert_instance_of(InsertIntoFile, @script.get_command_at(10))
    iif = @script.get_command_at(10)
    
    assert_equal('phpinfo.php', iif.get_filename)
    assert_equal('0', iif.get_line)
    
    text = iif.get_codesnippet
    text.strip!
    expected = "< ?php phpinfo(); ? >"
    assert_equal(expected, text)
  end
  
  #see line 113
  def test_declarevariables2
    assert_instance_of(DeclareVariables, @script.get_command_at(11))
    dv = @script.get_command_at(11)
    assert_equal(2, dv.get_variables().size)
    assert(dv.get_variables[0].include?('usernamemysql'))
    assert(dv.get_variables[1].include?('passwordmysql'))
    
  end
  
  # see line 114 - 118
  def test_beginfile10
    assert_instance_of(RootFile, @script.get_command_at(12))
    bf = @script.get_command_at(12)
    
    assert_equal('1', bf.get_section)
    assert_equal('installmysql.sh', bf.get_filename)
    assert_equal('install mysql', bf.get_id)
    assert_equal('UNIX', bf.get_platform)
    assert_equal('sh', bf.get_executor)
    
    text = bf.get_codesnippet
    text.strip!
    expected = "sudo apt-get install mysql-server mysql-client php5-mysql\n$.$-usernamemysql-$.$\n$.$-passwordmysql-$.$"
    assert_equal(expected, text)
  end
  
  # see line 121 - 123
  def test_beginfile11
    assert_instance_of(RootFile, @script.get_command_at(13))
    bf = @script.get_command_at(13)
    
    assert_equal('1', bf.get_section)
    assert_equal('restartpi.sh', bf.get_filename)
    assert_equal('restart pi', bf.get_id)
    assert_equal('UNIX', bf.get_platform)
    assert_equal('sh', bf.get_executor)
    
    text = bf.get_codesnippet
    text.strip!
    expected = "sudo restart"
    assert_equal(expected, text)
  end
  
  # see line 131 - 133
  def test_beginfile12
    assert_instance_of(RootFile, @script.get_command_at(14))
    bf = @script.get_command_at(14)
    
    assert_equal('1', bf.get_section)
    assert_equal('installphpmyadmin.sh', bf.get_filename)
    assert_equal('install phpMyAdmin', bf.get_id)
    assert_equal('UNIX', bf.get_platform)
    assert_equal('sh', bf.get_executor)
    
    text = bf.get_codesnippet
    text.strip!
    expected = "sudo apt-get install libapache2-mod-auth-mysql php5-mysql phpmyadmin"
    assert_equal(expected, text)
  end
  
  # see line 140 - 142
  def test_changefilelines1
    assert_instance_of(ChangeFileLines, @script.get_command_at(15))
    cfl = @script.get_command_at(15)
    
    assert_equal("/etc/php5/apache2/php.ini", cfl.get_filename)
    assert_equal("0", cfl.get_startline)
    assert_equal("1", cfl.get_endline)
    
    text = cfl.get_codesnippet
    text.strip!
    expected = "extension=mysql.so"
    assert_equal(expected, text)
  end
  
  # see line 139 - 141
  def test_beginfile13
    assert_instance_of(RootFile, @script.get_command_at(16))
    bf = @script.get_command_at(16)
    
    assert_equal('1', bf.get_section)
    assert_equal('addextension.sh', bf.get_filename)
    assert_equal('addextension', bf.get_id)
    assert_equal('UNIX', bf.get_platform)
    assert_equal('sh', bf.get_executor)
    
    text = bf.get_codesnippet
    text.strip!
    expected = "ln -s /etc/phpmyadmin/apache.conf /etc/apache2/conf.d/phpmyadmin.conf"
    assert_equal(expected, text)
  end
  
  # see line 149 - 151
  def test_beginfile14
    assert_instance_of(RootFile, @script.get_command_at(17))
    bf = @script.get_command_at(17)
    
    assert_equal('1', bf.get_section)
    assert_equal('installftp.sh', bf.get_filename)
    assert_equal('install ftp', bf.get_id)
    assert_equal('UNIX', bf.get_platform)
    assert_equal('sh', bf.get_executor)
    
    text = bf.get_codesnippet
    text.strip!
    expected = "sudo apt-get install proftpd"
    assert_equal(expected, text)
  end
  
  # see line 153 - 155
  def test_beginfile15
    assert_instance_of(RootFile, @script.get_command_at(18))
    bf = @script.get_command_at(18)
    
    assert_equal('1', bf.get_section)
    assert_equal('openproftpfile.sh', bf.get_filename)
    assert_equal('open ftp file', bf.get_id)
    assert_equal('UNIX', bf.get_platform)
    assert_equal('sh', bf.get_executor)
    
    text = bf.get_codesnippet
    text.strip!
    expected = "sudo nano /etc/proftpd/proftpd.conf"
    assert_equal(expected, text)
  end
  
  # see line 173
  def test_declarevariables3
    assert_instance_of(DeclareVariables, @script.get_command_at(19))
    dv = @script.get_command_at(19)
    
    assert_equal(2, dv.get_variables().size)
    assert(dv.get_variables[0].include?('usernameftp'))
    assert(dv.get_variables[1].include?('passwordftp'))
  end
  
  # see line 166 - 169
  def test_beginfile16
    assert_instance_of(RootFile, @script.get_command_at(20))
    bf = @script.get_command_at(20)
    
    assert_equal('1', bf.get_section)
    assert_equal('virtualuser.sh', bf.get_filename)
    assert_equal('virtual user', bf.get_id)
    assert_equal('UNIX', bf.get_platform)
    assert_equal('sh', bf.get_executor)
    
    text = bf.get_codesnippet
    text.strip!
    expected = "cd /etc/proftpd/\nsudo ftpasswd --passwd --name $.$-usernameftp-$.$ --uid 33 --gid 33 --home /var/www/ --shell /bin/false\n$.$-passwordftp-$.$"
    assert_equal(expected, text)
  end
  
  # see line 174 - 179
  def test_continuefile1
    assert_instance_of(ContinueFile, @script.get_command_at(21))
    cf = @script.get_command_at(21)
    
    assert_equal('2', cf.get_section)
    assert_equal('virtualuser.sh', cf.get_filename)
    
    text = cf.get_codesnippet
    text.strip!
    expected = "sudo /etc/init.d/proftpd restart\nchmod g+s /var/www\nchmod 775 /var/www\nchown -R www-data:www-data /var/www"
    assert_equal(expected, text)
    
    #TODO test beginfile relation
  end
  
end
