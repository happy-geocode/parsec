$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "parsec"

def check_parsing_result(parsed, street, number, city, zip, state, country)
  parsed.street_name.should == street
  parsed.city.should == city
  parsed.street_number.should == number
  parsed.zip.should == zip
  parsed.country.should == country
  parsed.state.should == state
end

