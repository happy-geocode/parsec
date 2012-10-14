require 'parsec/parsed_address'
require 'parsec/core_ext/string'

module Parsec
  module Parser
    class CommaSeparatedParser
      attr_reader :address

      def initialize(raw_address, knowledge_provider)
        @address            = ParsedAddress.new
        @knowledge_provider = knowledge_provider

        raw_address = take_apart raw_address
        raw_address = determine_street raw_address
        raw_address = determine_city raw_address
        raw_address = determine_state raw_address
        raw_address = determine_country raw_address

        if address.street_name.nil? and raw_address.length == 1
          @address.street_name, @address.street_number =
            @knowledge_provider.split_street_name_and_number raw_address.first
        end
      end

      def take_apart(raw_address)
        raw_address.split(",").map do |element|
          element.strip.normalize_for_parsec
        end
      end

      def determine_street(raw_address)
        raw_address.delete_if do |element|
          if @knowledge_provider.is_street? element
            @address.street_name, @address.street_number =
              @knowledge_provider.split_street_name_and_number element
            true
          end
        end

        raw_address
      end

      def determine_city(raw_address)
        city_with_zip = @knowledge_provider.city_with_zip_format

        raw_address.delete_if do |element|
          if element =~ city_with_zip
            zip, city_name = element.scan(city_with_zip).first
          else
            city_name, zip = element, nil
          end

          if @knowledge_provider.is_city? city_name
            city_name = city_name.split("-").first
            @address.city, @address.zip = city_name, zip
            true
          end
        end

        raw_address
      end

      def determine_state(raw_address)
        raw_address.delete_if do |element|
          if @knowledge_provider.is_state? element
            @address.state = element
            true
          end
        end

        raw_address
      end

      def determine_country(raw_address)
        raw_address.delete_if do |element|
          if @knowledge_provider.is_country? element
            @address.country = element
            true
          end
        end

        raw_address
      end
    end
  end
end
