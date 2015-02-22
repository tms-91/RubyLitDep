# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class Parserregistry
  
  def initialize
    @entries = Hash.new
  end
  
  def add_parser(parser)
    if(parser.kind_of?(CommandParser))
      parser_for = parser.get_parser_for
      @entries[parser_for] = parser
    end
  end
  
  def get_parser(parser_for)
    return @entries[parser_for]
  end
end
