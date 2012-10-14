# encoding: UTF-8
require 'unit/spec_helper'
require 'parsec/parser/commaless_monster'

describe "the German native" do
  let(:native) { double }
  subject { Parsec::Parser::CommalessMonster }

  before :each do
    native.stub(:zip_format).and_return(/\d{5}/)
    native.stub(:street_with_name_and_number).and_return(/(.+) (\d{1,4}(-\d{1,4})?\w?)/)

    native.stub(:is_street?) do |street_name|
      street_name == "lustige strasse 33"
    end

    native.stub(:is_city?) do |city_name|
      city_name == "aachen"
    end
  end

  it "split street, number, zip and city" do
    result = subject.new("lustige strasse 33 52070 aachen", native).address

    result.street_name.should == "lustige strasse"
    result.street_number.should == "33"
    result.zip.should == "52070"
    result.city.should == "aachen"
  end

  it "split street, number and city" do
    result = subject.new("lustige strasse 33 aachen", native).address

    result.street_name.should == "lustige strasse"
    result.street_number.should == "33"
    result.city.should == "aachen"
  end

  it "split street, zip and city" do
    result = subject.new("lustige strasse 52070 aachen", native).address

    result.street_name.should == "lustige strasse"
    result.zip.should == "52070"
    result.city.should == "aachen"
  end
end
