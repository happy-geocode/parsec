# encoding: UTF-8
require 'unit/spec_helper'
require 'parsec/native/de'

describe "the German native" do
  let(:city)    { double }
  let(:state)   { double }
  let(:country) { double }
  subject { Parsec::Native::De.new city, state, country }

  before :each do
    city.stub(:by_name).and_return({"koeln" => nil})
    state.stub(:by_code).and_return({"nrw" => nil})
    state.stub(:by_name).and_return({"bayern" => nil})
    country.stub(:by_code).and_return({"de" => nil})
    country.stub(:by_name).and_return({"deutschland" => nil})
  end

  it "should recognize a street without street number" do
    subject.is_street?("aachener strasse").should be_true
  end

  it "should recognize a street with street number" do
    subject.is_street?("aachener strasse 166").should be_true
  end

  it "should recognize a street with street number and add-on" do
    subject.is_street?("aachener strasse 166a").should be_true
  end

  it "should recognize a street with street number range" do
    subject.is_street?("aachener strasse 166-168").should be_true
  end

  it "should recognize a street with street number range and add-on" do
    subject.is_street?("aachener strasse 166-168a").should be_true
  end

  it "should not recognize Koeln as a street" do
    subject.is_street?("koeln").should be_false
  end

  it "should recognize a city match" do
    subject.is_city?("koeln").should be_true
  end

  it "should recognize a partial city match" do
    subject.is_city?("koeln-weiden").should be_true
  end

  it "should not recognize a city that does not exist" do
    subject.is_city?("fatasiestadt").should be_false
  end

  it "should recognize a state abbreviation" do
    subject.is_state?("nrw").should be_true
  end

  it "should recognize a full state name" do
    subject.is_state?("bayern").should be_true
  end

  it "should not recognize a state that does not exist" do
    subject.is_state?("fatasiestaat").should be_false
  end

  it "should recognize Germany as a country" do
    subject.is_country?("deutschland").should be_true
  end

  it "should not recognize a country that does not exist" do
    subject.is_country?("fatasieland").should be_false
  end

  it "should split a street without a number" do
    split = subject.split_street_name_and_number "aachener strasse 166"
    split[0].should == "aachener strasse"
    split[1].should == "166"
  end

  it "should split a street with a number" do
    split = subject.split_street_name_and_number "aachener strasse"
    split[0].should == "aachener strasse"
    split[1].should be_nil
  end
end
