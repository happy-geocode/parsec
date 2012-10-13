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
        raw_address, address = GermanParser.determine_state raw_address, address
        raw_address, address = GermanParser.determine_country raw_address, address

        address
      end

      def GermanParser.deabbriviate(raw_address)
        raw_address.gsub("str.", "strasse")
      end

      def GermanParser.take_apart(raw_address)
        raw_address.split(",").map do |element|
          GermanParser.deabbriviate element.strip.normalize_for_parsec
        end
      end

      def GermanParser.is_street?(raw)
        raw.include? "strasse"
      end

      def GermanParser.split_street_name_and_number(raw_street)
        street_with_number = /(.+) (\d+(-\d+)?\w?)/

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
        city_with_zip = /(\d+) (.+)/

        raw_address.delete_if do |element|
          if element =~ city_with_zip
            zip, city_name = element.scan(city_with_zip).first
          else
            city_name, zip = element, nil
          end

          if GermanParser.is_city? city_name
            address.city, address.zip = city_name, zip
            true
          end
        end

        [raw_address, address]
      end

      def GermanParser.is_state?(raw)
        Parsec::Knowledge::State.by_name.has_key? raw or
          Parsec::Knowledge::State.by_code.has_key? raw
      end

      def GermanParser.determine_state(raw_address, address)
        raw_address.delete_if do |element|
          if GermanParser.is_state? element
            address.state = element
            true
          end
        end

        [raw_address, address]
      end

      def GermanParser.is_country?(raw)
        Parsec::Knowledge::Country.by_name.has_key? raw or
          Parsec::Knowledge::Country.by_code.has_key? raw
      end

      def GermanParser.determine_country(raw_address, address)
        raw_address.delete_if do |element|
          if GermanParser.is_country? element
            address.country = element
            true
          end
        end

        [raw_address, address]
      end
    end
  end
end
