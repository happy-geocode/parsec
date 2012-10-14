require "parsec/knowledge"

module Parsec
  module Native
    # This guy knows a lot about Germany
    class German
      def is_street?(raw)
        raw.include? "strasse"
      end

      def is_city?(raw)
        if Parsec::Knowledge::City.by_name.has_key? raw
          true
        elsif raw.include? "-"
          raw = raw.split("-").first
          Parsec::Knowledge::City.by_name.has_key? raw
        end
      end

      def is_state?(raw)
        Parsec::Knowledge::State.by_name.has_key? raw or
          Parsec::Knowledge::State.by_code.has_key? raw
      end

      def is_country?(raw)
        Parsec::Knowledge::Country.by_name.has_key? raw or
          Parsec::Knowledge::Country.by_code.has_key? raw
      end

      def split_street_name_and_number(raw_street)
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
