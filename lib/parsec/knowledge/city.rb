module Parsec
  module Knowledge
    class City
      attr_reader :name
      attr_accessor :state

      class << self
        attr_accessor :by_name

        City.by_name = {}
      end

      def City.find_or_create(name)
        if self.by_name[name].nil?
          city = self.new name
          self.by_name[name] = city

          city
        else
          self.by_name[name]
        end
      end

      def initialize(name)
        @name = name
      end

      def zips
        CityZipMapper.zips_for_city[@name]
      end

      def to_s
        @name.to_s
      end
    end
  end
end
