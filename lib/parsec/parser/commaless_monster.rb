require 'parsec/parsed_address'
require 'parsec/core_ext/string'

module Parsec
  module Parser
    # This beast will eat those strings without any comma
    class CommalessMonster
      attr_reader :address

      def initialize(raw_address, native)
        @address = ParsedAddress.new
        @native  = native

        raw_address = raw_address.normalize_for_parsec
        raw_address = rip_out_zip raw_address
        raw_address = rip_out_complete_street raw_address
        raw_address = rip_out_city raw_address

        if @address.street_name.nil? and raw_address.length > 0
          @address.street_name = raw_address
        end
      end

      def rip_out_zip(raw_string)
        zip = raw_string.scan @native.zip_format

        if zip.length == 1
          @address.zip = zip.first
          raw_string.gsub! @address.zip, ""
        end

        raw_string
      end

      def rip_out_complete_street(raw_string)
        street = raw_string.scan @native.street_with_name_and_number
        delete_me = ""

        if street.length == 1
          @address.street_name, @address.street_number =
            street.first

          delete_me = street.first.join(" ").strip
        end

        raw_string.gsub delete_me, ""
      end

      def rip_out_city(raw_string)
        candidates = raw_string.split(/\s+/)

        candidates.delete_if do |candidate|
          if @native.is_city? candidate
            @address.city = candidate
            true
          end
        end.join " "
      end
    end
  end
end
