require "parsec/core_ext/string"
require "parsec/parsed_address"
require "parsec/knowledge"
require "parsec/native/de"
require "parsec/parser/commaless_monster"
require "parsec/parser/comma_separated_parser"

module Parsec
  module Parser
    class DeParser
      def DeParser.parse(raw_address)
        native = Parsec::Native::De.new Parsec::Knowledge::City,
          Parsec::Knowledge::State,
          Parsec::Knowledge::Country

        if raw_address.include? ","
          parser = CommaSeparatedParser.new raw_address, native
        else
          parser = CommalessMonster.new raw_address, native
        end

        parser.address
      end
    end
  end
end
