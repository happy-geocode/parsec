require "parsec/version"
require "parsec/knowledge"
require "parsec/parsed_address"
require "parsec/parser"

module Parsec
  # Setup Parsec for parsing - just call it at startup
  def Parsec.setup
    Parsec::Knowledge.import File.expand_path("../../raw_data/DE.txt", __FILE__)
    Knowledge.common_knowledge
  end

  def Parsec.parse(raw_address)
    Parser::GermanParser.parse raw_address
  end
end
