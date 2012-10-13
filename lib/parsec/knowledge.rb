require "parsec/knowledge/country"
require "parsec/knowledge/state"
require "parsec/knowledge/zip"
require "parsec/knowledge/city"
require "parsec/knowledge/city_zip_mapper"

module Parsec
  # The knowledge of the parser about countries, cities etc.
  module Knowledge
      # Import Preknowledge from [Geonames](http://www.geonames.org)
      def Knowledge.import(filename)
        File.read(filename).each_line do |line|
          country_code, zip_code, place_name, state_name, state_code =
            line.split("\t")

          # Store the knowledge
          country = Country.find_or_create 'Deutschland', country_code
          state   = State.find_or_create state_name, state_code
          zip     = Zip.find_or_create zip_code
          city    = City.find_or_create place_name

          # Connect the knowledge
          unless country.states.include? state or state.name == ""
            country.states << state
            state.country = country
          end

          unless state.zips.include? zip
            state.zips << zip
            zip.state = state
          end

          unless state.cities.include? city
            state.cities << city
            city.state = state
          end

          CityZipMapper.connect city, zip
        end
      end
  end
end
