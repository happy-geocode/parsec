$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "parsec"

Parsec.setup

def check_parsing_result(parsed, street, number, city, zip, state, country)
  parsed.street_name.should == street
  parsed.street_number.should == number
  parsed.city.should == city
  parsed.zip.should == zip
  parsed.state.should == state
  parsed.country.should == country
end
