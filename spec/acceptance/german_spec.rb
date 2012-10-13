# encoding: UTF-8
require 'acceptance/spec_helper'

describe "should work with German addresses" do
  subject { Parsec }

  it "should work with the example from the README" do
    pending "Not implemened yet"
    check_parsing_result(subject.parse("Hauptstraße 24, Köln"),
                         "Hauptstrasse", 24, "Koeln", nil, nil, nil)
  end

  it "should parse simple address with zip code" do
    pending "Not implemened yet"
    check_parsing_result(subject.parse("Hauptstraße 24, 50739 Köln, NRW, Deutschland"),
                         "Hauptstrasse", 24, "Koeln", 50739, "NRW", "Deutschland")
  end

  it "should parse str. and change it to strasse" do
    pending "Not implemened yet"
    check_parsing_result(subject.parse("Hauptstr. 24, 50739 Köln, NRW, Deutschland"),
                         "Hauptstrasse", 24, "Koeln", 50739, "NRW", "Deutschland")
  end

  it "should parse street without number" do
    pending "Not implemened yet"
    check_parsing_result(subject.parse("Hauptstr., 50739 Köln, NRW, Deutschland"),
                         "Hauptstrasse", nil, "Koeln", 50739, "NRW", "Deutschland")
  end

  it "should parse address without any commas" do
    pending "Not implemened yet"
    check_parsing_result(subject.parse("Hauptstrasse 12 Köln"),
                         "Hauptstrasse", 12, "Koeln", nil, nil, nil)
  end

  it "should parse address without any commas including a zip code" do
    pending "Not implemened yet"
    check_parsing_result(subject.parse("Hauptstrasse 12 50739 Köln"),
                         "Hauptstrasse", 12, "Koeln", 50739, nil, nil)
  end

  it "should parse address without any commas with zip but without street number" do
    pending "Not implemened yet"
    check_parsing_result(subject.parse("Hauptstrasse 50739 Köln"),
                         "Hauptstrasse", nil, "Koeln", 50739, nil, nil)
  end

  it "should parse address with city first" do
    pending "Not implemened yet"
    check_parsing_result(subject.parse("Köln Hauptstrasse"),
                         "Hauptstrasse", nil, "Koeln", nil, nil, nil)
  end

  it "...weg means it is a street, too" do
    pending "Not implemened yet"
    check_parsing_result(subject.parse("Köln Hauptweg"),
                         "Hauptweg", nil, "Koeln", nil, nil, nil)
  end

  it "...gasse means it is a street, too" do
    pending "Not implemened yet"
    check_parsing_result(subject.parse("Köln Hauptgasse"),
                         "Hauptgasse", nil, "Koeln", nil, nil, nil)
  end

  it "...gässle means it is a street, too" do
    pending "Not implemened yet"
    check_parsing_result(subject.parse("Köln Hauptgässle"),
                         "Hauptgässle", nil, "Koeln", nil, nil, nil)
  end

  it "small city with a subvillage address" do
    pending "Not implemened yet"
    check_parsing_result(subject.parse("Im Raitgorn 19, 48496 Hopsten-Schale"),
                         "Im Raitgorn", 19, "Hopsten", 48496, nil, nil)
  end

end
