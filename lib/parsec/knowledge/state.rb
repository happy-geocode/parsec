module Parsec
  module Knowledge
    class State
      attr_reader :name
      attr_reader :code
      attr_accessor :country
      attr_accessor :zips
      attr_accessor :cities

      class << self
        attr_accessor :by_name
        attr_accessor :by_code

        State.by_name = {}
        State.by_code = {}
      end

      def State.find_or_create(name, code)
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
        @name = name
        @code = code
        @zips = []
        @cities  = []
      end

      def to_s
        @name.to_s
      end
    end
  end
end
