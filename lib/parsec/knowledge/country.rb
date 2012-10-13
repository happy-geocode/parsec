module Parsec
  module Knowledge
    class Country
      attr_reader :name
      attr_reader :code
      attr_accessor :states

      class << self
        attr_accessor :by_name
        attr_accessor :by_code

        Country.by_name = {}
        Country.by_code = {}
      end

      def Country.find_or_create(name, code)
        if self.by_code[code].nil?
          country = self.new name, code
          self.by_name[name] = country
          self.by_code[code] = country

          country
        else
          self.by_code[code]
        end
      end

      def initialize(name, code)
        @states = []
        @name = name
        @code = code
      end
    end
  end
end
