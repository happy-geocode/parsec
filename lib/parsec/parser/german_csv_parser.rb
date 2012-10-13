module Parsec
  module Parser
    class GermanCSVParser
      attr_reader :address

      def initialize(raw_address)
        @address = ParsedAddress.new

        raw_address = GermanParser.take_apart raw_address
        raw_address, @address = GermanParser.determine_street raw_address, @address
        raw_address, @address = GermanParser.determine_city raw_address, @address
        raw_address, @address = GermanParser.determine_state raw_address, @address
        raw_address, @address = GermanParser.determine_country raw_address, @address

        if address.street_name.nil? and raw_address.length == 1
          @address.street_name, @address.street_number =
            GermanParser.split_street_name_and_number raw_address.first
        end
      end
    end
  end
end
