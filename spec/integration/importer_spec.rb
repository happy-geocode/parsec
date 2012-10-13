# encoding: UTF-8
require 'integration/spec_helper'
require 'parsec/knowledge'

describe "the knowledge of the parser" do
  describe "the imported knowledge" do
    before :all do
      Parsec::Knowledge.import "raw_data/DE.txt"
    end

    it "should know the country Germany" do
      Parsec::Knowledge::Country.by_code["de"].should_not be_nil
    end

    it "should know the states of Germany" do
      Parsec::Knowledge::State.by_code
      Parsec::Knowledge::State.by_code["nw"].should_not be_nil
    end

    it "should know how many states Germany has" do
      Parsec::Knowledge::Country.by_code["de"].states.length.should == 16
    end

    it "should know that NRW is in Germany" do
      state   = Parsec::Knowledge::State.by_code["nw"]
      country = Parsec::Knowledge::Country.by_code["de"]
      state.country.should == country
    end

    it "should collect all the zip codes" do
      Parsec::Knowledge::Zip.by_code["50859"].should_not be_nil
    end

    it "should find the zip 50859 in NRW" do
      zip = Parsec::Knowledge::Zip.by_code["50859"]
      Parsec::Knowledge::State.by_code["nw"].zips.should include zip
    end

    it "should find the state for the zip 50859" do
      zip = Parsec::Knowledge::Zip.by_code["50859"]
      state = Parsec::Knowledge::State.by_code["nw"]
      zip.state.should == state
    end

    it "should collect all the cities" do
      Parsec::Knowledge::City.by_name["berlin"].should_not be_nil
    end

    it "should find the city Bonn in NRW" do
      city = Parsec::Knowledge::City.by_name["bonn"]
      Parsec::Knowledge::State.by_code["nw"].cities.should include city
    end

    it "should find the state for the city Bonn" do
      city = Parsec::Knowledge::City.by_name["bonn"]
      state = Parsec::Knowledge::State.by_code["nw"]
      city.state.should == state
    end

    it "should find the postal codes of Cologne" do
      city = Parsec::Knowledge::City.by_name["koeln"]
      zip = Parsec::Knowledge::Zip.by_code["50859"]
      city.zips.should include zip
    end

    it "should find the Cites for the postal 50859" do
      city = Parsec::Knowledge::City.by_name["koeln"]
      zip = Parsec::Knowledge::Zip.by_code["50859"]
      zip.cities.should include city
    end
  end

  describe "the additional common knowledge" do
    before :all do
      Parsec::Knowledge.import "raw_data/DE.txt"
      Parsec::Knowledge.common_knowledge
    end

    it "should find NRW in the states" do
      nw = Parsec::Knowledge::State.by_code["nw"]
      nrw = Parsec::Knowledge::State.by_code["nrw"]
      nw.should == nrw
    end
  end
end
