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
    let(:knowledge_provider) { Parsec::Parser::GermanParser }
    subject { Parsec::Parser::GermanCSVParser }

    it "should parse street and city" do
      result = subject.new("Aachener Straße, Köln", knowledge_provider).address
      result.street_name.should == "aachener strasse"
      result.city.should        == "koeln"
    end

    it "should parse street with number and city" do
      result = subject.new("Aachener Straße 166, Köln", knowledge_provider).address
      result.street_name.should   == "aachener strasse"
      result.street_number.should == "166"
      result.city.should          == "koeln"
    end

    it "should parse street with number and city with zip code" do
      result = subject.new("Aachener Straße 166, 50931 Köln", knowledge_provider).address

      result.street_name.should   == "aachener strasse"
      result.street_number.should == "166"
      result.city.should          == "koeln"
      result.zip.should           == "50931"
    end

    it "should parse full address" do
      result = subject.new("Aachener Straße 166, 50931 Köln, NRW, Deutschland", knowledge_provider).address

      result.street_name.should   == "aachener strasse"
      result.street_number.should == "166"
      result.city.should          == "koeln"
      result.zip.should           == "50931"
      result.state.should         == "nrw"
      result.country.should       == "deutschland"
    end

    it "should parse an abbreviated street name" do
      result = subject.new("Aachener Str. 166", knowledge_provider).address
      result.street_name.should   == "aachener strasse"
      result.street_number.should == "166"
    end

    it "should accept an optional addon for the street number" do
      result = subject.new("Aachener Str. 166a", knowledge_provider).address
      result.street_name.should   == "aachener strasse"
      result.street_number.should == "166a"
    end

    it "should accept an street number range" do
      result = subject.new("Aachener Str. 166-168", knowledge_provider).address
      result.street_name.should   == "aachener strasse"
      result.street_number.should == "166-168"
    end

    it "should guess that an arbitrary string that remains soley must be the street" do
      result = subject.new("Bullibu 166, 50931 Köln, NRW, Deutschland", knowledge_provider).address

      result.street_name.should   == "bullibu"
      result.street_number.should == "166"
      result.city.should          == "koeln"
      result.zip.should           == "50931"
      result.state.should         == "nrw"
      result.country.should       == "deutschland"
    end

    it "should understand a partial city match" do
      result = subject.new("Aachener Straße, 48496 Hopsten-Schale", knowledge_provider).address

      result.zip.should   == "48496"
      result.city.should  == "hopsten"
    end
  end
end
