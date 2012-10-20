require "parsec/knowledge"
require "parsec/parser/commaless_monster"
require "parsec/parser/comma_separated_parser"

module Parsec
  module Parser
    def Parser.parse(native_class, raw_address)
      native = native_class.new Parsec::Knowledge::City,
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
