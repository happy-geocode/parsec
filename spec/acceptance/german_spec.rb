# encoding: UTF-8
require 'acceptance/spec_helper'

describe "should work with German addresses" do
  subject { Parsec }

  it "should work with the example from the README" do
    pending "Not implemented yet"
    parsed = subject.parse("Hauptstraße 23, Köln")

    parsed.street_name.should == "Hauptstrasse"
    parsed.city.should == "Koeln"
    parsed.street_number.should == 23
    parsed.zip.should == nil
    parsed.country.should == nil
    parsed.state.should == nil
  end
end
