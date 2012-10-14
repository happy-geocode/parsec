module Parsec
  module Native
    # This guy knows a lot about Germany
    class German
      attr_reader :city_with_zip_format
      attr_reader :street_with_name_and_number

      def initialize(city, state, country)
        @city    = city
        @state   = state
        @country = country

        @city_with_zip_format        = /(\d{5}) (.+)/
        @street_with_name_and_number = /(.+) (\d{1,4}(-\d{1,4})?\w?)/
      end

      def is_street?(raw)
        raw.include? "strasse"
      end

      def is_city?(raw)
        if @city.by_name.has_key? raw
          true
        elsif raw.include? "-"
          raw = raw.split("-").first
          @city.by_name.has_key? raw
        end
      end

      def is_state?(raw)
        @state.by_name.has_key? raw or
          @state.by_code.has_key? raw
      end

      def is_country?(raw)
        @country.by_name.has_key? raw or
          @country.by_code.has_key? raw
      end

      def split_street_name_and_number(raw_street)
        if raw_street =~ @street_with_name_and_number
          raw_street.scan(@street_with_name_and_number).first
        else
          [raw_street, nil]
        end
      end
    end
  end
end
