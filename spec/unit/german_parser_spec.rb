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

    it "should parse street with number and city with zip code" do
      result = subject.parse_comma_separated_string "Aachener Straße 166, 50931 Köln"

      result.street_name.should   == "aachener strasse"
      result.street_number.should == "166"
      result.city.should          == "koeln"
      result.zip.should           == "50931"
    end

    it "should parse full address" do
      result = subject.parse_comma_separated_string "Aachener Straße 166, 50931 Köln, NRW, Deutschland"

      result.street_name.should   == "aachener strasse"
      result.street_number.should == "166"
      result.city.should          == "koeln"
      result.zip.should           == "50931"
      result.state.should         == "nrw"
      result.country.should       == "deutschland"
    end

    it "should parse an abbreviated street name" do
      result = subject.parse_comma_separated_string "Aachener Str. 166"
      result.street_name.should   == "aachener strasse"
      result.street_number.should == "166"
    end

    it "should accept an optional addon for the street number" do
      result = subject.parse_comma_separated_string "Aachener Str. 166a"
      result.street_name.should   == "aachener strasse"
      result.street_number.should == "166a"
    end

    it "should accept an street number range" do
      result = subject.parse_comma_separated_string "Aachener Str. 166-168"
      result.street_name.should   == "aachener strasse"
      result.street_number.should == "166-168"
    end

    it "should guess that an arbitrary string that remains soley must be the street" do
      result = subject.parse_comma_separated_string "Bullibu 166, 50931 Köln, NRW, Deutschland"

      result.street_name.should   == "bullibu"
      result.street_number.should == "166"
      result.city.should          == "koeln"
      result.zip.should           == "50931"
      result.state.should         == "nrw"
      result.country.should       == "deutschland"
    end

    it "should understand a partial city match" do
      result = subject.parse_comma_separated_string "Aachener Straße, 48496 Hopsten-Schale"

      result.zip.should   == "48496"
      result.city.should  == "hopsten"
    end
  end
end

