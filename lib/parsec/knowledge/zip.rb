module Parsec
  module Knowledge
    class Zip
      attr_reader :code
      attr_accessor :state

      class << self
        attr_accessor :by_code

        Zip.by_code = {}
      end

      def Zip.find_or_create(code)
        if self.by_code[code].nil?
          zip = self.new code
          self.by_code[code] = zip

          zip
        else
          self.by_code[code]
        end
      end

      def initialize(code)
        @code = code
      end

      def cities
        CityZipMapper.cities_for_zip[@code]
      end

      def to_s
        code.to_s
      end
    end
  end
end
