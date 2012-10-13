module Parsec
  module Parser
    class GermanCSVParser
      attr_reader :address

      def initialize(raw_address)
        @address = ParsedAddress.new

        raw_address = GermanCSVParser.take_apart raw_address
        raw_address = determine_street raw_address
        raw_address = determine_city raw_address
        raw_address = determine_state raw_address
        raw_address = determine_country raw_address

        if address.street_name.nil? and raw_address.length == 1
          @address.street_name, @address.street_number =
            GermanParser.split_street_name_and_number raw_address.first
        end
      end

      def GermanCSVParser.take_apart(raw_address)
        raw_address.split(",").map do |element|
          GermanParser.clean_string element.strip
        end
      end

      def determine_street(raw_address)
        raw_address.delete_if do |element|
          if GermanParser.is_street? element
            @address.street_name, @address.street_number =
              GermanParser.split_street_name_and_number element
            true
          end
        end

        raw_address
      end

      def determine_city(raw_address)
        city_with_zip = /(\d+) (.+)/

        raw_address.delete_if do |element|
          if element =~ city_with_zip
            zip, city_name = element.scan(city_with_zip).first
          else
            city_name, zip = element, nil
          end

          if GermanParser.is_city? city_name
            city_name = city_name.split("-").first
            @address.city, @address.zip = city_name, zip
            true
          end
        end

        raw_address
      end

      def determine_state(raw_address)
        raw_address.delete_if do |element|
          if GermanParser.is_state? element
            @address.state = element
            true
          end
        end

        raw_address
      end

      def determine_country(raw_address)
        raw_address.delete_if do |element|
          if GermanParser.is_country? element
            @address.country = element
            true
          end
        end

        raw_address
      end
    end
  end
end
