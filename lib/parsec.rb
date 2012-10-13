require "parsec/version"
require "parsec/knowledge"

module Parsec
  # Setup Parsec for parsing - just call it at startup
  def Parsec.setup
    Parsec::Knowledge.import "raw_data/DE.txt"
    Knowledge.common_knowledge
  end
end
