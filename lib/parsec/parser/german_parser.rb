require "parsec/parsed_address"
require "parsec/core_ext/string"
require "parsec/knowledge"
require "parsec/parser/german_csv_parser"

module Parsec
  module Parser
    class GermanParser
      def GermanParser.parse(raw_address)
        parser = GermanCSVParser.new raw_address
        parser.address
      end

      def GermanParser.clean_string(raw_address)
        raw_address.normalize_for_parsec.gsub("str.", "strasse")
      end

      def GermanParser.is_street?(raw)
        raw.include? "strasse"
      end

      def GermanParser.is_city?(raw)
        if Parsec::Knowledge::City.by_name.has_key? raw
          true
        elsif raw.include? "-"
          raw = raw.split("-").first
          Parsec::Knowledge::City.by_name.has_key? raw
        end
      end

      def GermanParser.is_state?(raw)
        Parsec::Knowledge::State.by_name.has_key? raw or
          Parsec::Knowledge::State.by_code.has_key? raw
      end

      def GermanParser.is_country?(raw)
        Parsec::Knowledge::Country.by_name.has_key? raw or
          Parsec::Knowledge::Country.by_code.has_key? raw
      end

      def GermanParser.split_street_name_and_number(raw_street)
        street_with_number = /(.+) (\d+(-\d+)?\w?)/

        if raw_street =~ street_with_number
          raw_street.scan(street_with_number).first
        else
          [raw_street, nil]
        end
      end
    end
  end
end
