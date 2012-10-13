require "parsec/parsed_address"
require "parsec/core_ext/string"
require "parsec/knowledge"

module Parsec
  module Parser
    class GermanParser
      def GermanParser.parse(raw_address)
        GermanParser.parse_comma_separated_string raw_address
      end

      def GermanParser.parse_comma_separated_string(raw_address)
        address = ParsedAddress.new

        raw_address = GermanParser.take_apart raw_address
        raw_address, address = GermanParser.determine_street raw_address, address
        raw_address, address = GermanParser.determine_city raw_address, address

        address
      end

      def GermanParser.take_apart(raw_address)
        raw_address.split(",").map do |element|
          element.strip.normalize_for_parsec
        end
      end

      def GermanParser.is_street?(raw)
        raw.include? "strasse"
      end

      def GermanParser.split_street_name_and_number(raw_street)
        street_with_number = /(.+) (\d+)/

        if raw_street =~ street_with_number
          raw_street.scan(street_with_number).first
        else
          [raw_street, nil]
        end
      end

      def GermanParser.determine_street(raw_address, address)
        raw_address.delete_if do |element|
          if GermanParser.is_street? element
            address.street_name, address.street_number =
              GermanParser.split_street_name_and_number element
            true
          end
        end

        [raw_address, address]
      end

      def GermanParser.is_city?(raw)
        Parsec::Knowledge::City.by_name.has_key? raw
      end

      def GermanParser.determine_city(raw_address, address)
        raw_address.delete_if do |element|
          if GermanParser.is_city? element
            address.city = element
            true
          end
        end

        [raw_address, address]
      end
    end
  end
end
