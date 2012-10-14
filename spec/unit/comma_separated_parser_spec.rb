# encoding: UTF-8
require 'unit/spec_helper'
require 'parsec/parser/comma_separated_parser'

describe "Comma separated String parser" do
  let(:knowledge_provider) { double }
  subject { Parsec::Parser::CommaSeparatedParser }

  before :each do
    knowledge_provider.stub :is_street? do |name|
      name == "aachener strasse"
    end
    knowledge_provider.stub :split_street_name_and_number do |street|
      if street == "aachener strasse"
        ["aachener strasse", nil]
      elsif street == "aachener strasse 166"
        ["aachener strasse", "166"]
      end
    end
    knowledge_provider.stub :is_city? do |city|
      city == "koeln" or city == "koeln-weiden"
    end
    knowledge_provider.stub :is_state? do |state|
      state == "nrw"
    end
    knowledge_provider.stub :is_country? do |state|
      state == "deutschland"
    end
    knowledge_provider.stub(:city_with_zip_format).and_return(/(\d+) (.+)/)
  end

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

  it "should understand a partial city match" do
    result = subject.new("Aachener Straße, 50931 Köln-Weiden", knowledge_provider).address
    result.city.should  == "koeln"
  end
end
