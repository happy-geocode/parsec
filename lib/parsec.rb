require "parsec/version"
require "parsec/knowledge"
require "parsec/parsed_address"
require "parsec/parser"

module Parsec

  # Setup Parsec for parsing - just call it at startup
  def Parsec.setup(country = "de")
    @country = country

    # Load up country's knowledge file
    knowledge_file = "../../raw_data/#{country.upcase}.txt"
    Parsec::Knowledge.import File.expand_path(knowledge_file, __FILE__)

    # TODO: decouple common_knowledge from german Laender abbreviations
    Knowledge.common_knowledge

    # Load up the native and parser for this country
    require "parsec/native/#{country}"
    require "parsec/parser/#{country}_parser"
  end

  def Parsec.parse(raw_address)
    Parser.const_get("#{@country.capitalize}Parser").parse raw_address
  end
end
