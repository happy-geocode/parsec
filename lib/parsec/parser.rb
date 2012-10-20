require "parsec/parser/commaless_monster"
require "parsec/parser/comma_separated_parser"

module Parsec
  module Parser
    def Parser.parse(native, raw_address)
      if raw_address.include? ","
        parser = CommaSeparatedParser.new raw_address, native
      else
        parser = CommalessMonster.new raw_address, native
      end

      parser.address
    end
  end
end
