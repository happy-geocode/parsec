module Parsec
  module Knowledge
    class CityZipMapper
      class << self
        attr_accessor :cities_for_zip
        attr_accessor :zips_for_city

        CityZipMapper.cities_for_zip = {}
        CityZipMapper.zips_for_city = {}
      end

      def CityZipMapper.connect(city, zip)
        CityZipMapper.zips_for_city[city.name] ||= []
        CityZipMapper.zips_for_city[city.name] << zip
        CityZipMapper.cities_for_zip[zip.code] ||= []
        CityZipMapper.cities_for_zip[zip.code] << city
      end
    end
  end
end
