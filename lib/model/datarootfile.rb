# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require 'model/rootfile'

class DataRootFile < RootFile
  def initialize(id,snippet, section, filename, platform, executor,varname)
    super(id,snippet, section, filename, platform, executor)
    @varname = varname
  end
  
  def get_varname
    @varname
  end
  
end
