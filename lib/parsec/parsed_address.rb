module Parsec
  class ParsedAddress < Struct.new(:street_name, :street_number, :city, :zip, :state, :country)
  end
end
