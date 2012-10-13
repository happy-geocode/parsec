require "parsec/version"
require "parsec/knowledge"
require "parsec/parsed_address"

module Parsec
  # Setup Parsec for parsing - just call it at startup
  def Parsec.setup
    Parsec::Knowledge.import "raw_data/DE.txt"
    Knowledge.common_knowledge
  end

  def Parsec.parse(raw_string)
    ParsedAddress.new
  end
end
