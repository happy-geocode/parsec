# encoding: UTF-8
require 'unit/spec_helper'
require 'parsec/parser/german_parser'

describe "the German parser" do
  subject { Parsec::Parser::GermanParser }

  before(:all) do
    Parsec::Knowledge.import "raw_data/DE.txt"
    Parsec::Knowledge.common_knowledge
  end

  describe "Comma separated String parser" do
    it "should parse street and city" do
      result = subject.parse_comma_separated_string "Aachener Straße, Köln"
      result.street_name.should == "aachener strasse"
      result.city.should        == "koeln"
    end

    it "should parse street with number and city" do
      result = subject.parse_comma_separated_string "Aachener Straße 166, Köln"
      result.street_name.should   == "aachener strasse"
      result.street_number.should == "166"
      result.city.should          == "koeln"
    end
  end
end

