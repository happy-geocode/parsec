require "parsec/core_ext/string"
require "parsec/parsed_address"
require "parsec/knowledge"
require "parsec/native/german"
require "parsec/parser/comma_separated_parser"

module Parsec
  module Parser
    class GermanParser
      def GermanParser.parse(raw_address)
        native = Parsec::Native::German.new Parsec::Knowledge::City,
          Parsec::Knowledge::State,
          Parsec::Knowledge::Country
        parser = CommaSeparatedParser.new raw_address, native
        parser.address
      end
    end
  end
end
