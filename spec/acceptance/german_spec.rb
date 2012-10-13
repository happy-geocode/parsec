# encoding: UTF-8
require 'acceptance/spec_helper'

describe "should work with German addresses" do
  subject { Parsec }

  it "should work with the example from the README" do
    check_parsing_result(subject.parse("Hauptstraße 24, Köln"),
                         "hauptstrasse", "24", "koeln", nil, nil, nil)
  end

  it "should parse simple address with zip code" do
    check_parsing_result(subject.parse("Hauptstraße 24, 50739 Köln, NRW, Deutschland"),
                         "hauptstrasse", "24", "koeln", "50739", "nrw", "deutschland")
  end

  it "should parse str. and change it to strasse" do
    check_parsing_result(subject.parse("Hauptstr. 24, 50739 Köln, NRW, Deutschland"),
                         "hauptstrasse", "24", "koeln", "50739", "nrw", "deutschland")
  end

  it "should parse street without number" do
    check_parsing_result(subject.parse("Hauptstr., 50739 Köln, NRW, Deutschland"),
                         "hauptstrasse", nil, "koeln", "50739", "nrw", "deutschland")
  end

  it "should parse address without any commas" do
    pending "Not implemened yet"
    check_parsing_result(subject.parse("Hauptstrasse 12 Köln"),
                         "hauptstrasse", "12", "koeln", nil, nil, nil)
  end

  it "should parse address without any commas including a zip code" do
    pending "Not implemened yet"
    check_parsing_result(subject.parse("Hauptstrasse 12 50739 Köln"),
                         "hauptstrasse", "12", "koeln", "50739", nil, nil)
  end

  it "should parse address without any commas with zip but without street number" do
    pending "Not implemened yet"
    check_parsing_result(subject.parse("Hauptstrasse 50739 Köln"),
                         "hauptstrasse", nil, "koeln", "50739", nil, nil)
  end

  it "should parse address with city first" do
    pending "Not implemened yet"
    check_parsing_result(subject.parse("Köln Hauptstrasse"),
                         "hauptstrasse", nil, "koeln", nil, nil, nil)
  end

  it "...weg means it is a street, too" do
    pending "Not implemened yet"
    check_parsing_result(subject.parse("Köln Hauptweg"),
                         "hauptweg", nil, "koeln", nil, nil, nil)
  end

  it "...gasse means it is a street, too" do
    pending "Not implemened yet"
    check_parsing_result(subject.parse("Köln Hauptgasse"),
                         "hauptgasse", nil, "koeln", nil, nil, nil)
  end

  it "...gässle means it is a street, too" do
    pending "Not implemened yet"
    check_parsing_result(subject.parse("Köln Hauptgässle"),
                         "hauptgässle", nil, "koeln", nil, nil, nil)
  end

  it "should parse a small city with a subvillage address" do
    pending "Not implemened yet"
    check_parsing_result(subject.parse("Im Raitgorn 19, 48496 Hopsten-Schale"),
                         "im raitgorn", "19", "hopsten", "48496", nil, nil)
  end

  it "should recognize street numbers with letters in it" do
    check_parsing_result(subject.parse("Hauptstrasse 12a, 50739 Köln"),
                         "hauptstrasse", "12a", "koeln", "50739", nil, nil)
  end

  it "should recognize street numbers with range" do
    pending "Not implemened yet"
    check_parsing_result(subject.parse("Hauptstrasse 12-20a, 50739 Köln"),
                         "hauptstrasse", "12-20a", "koeln", "50739", nil, nil)
  end

  it "should recognize addresses with street and number at last position" do
    check_parsing_result(subject.parse("50739 Köln, Hauptstrasse 12a"),
                         "hauptstrasse", "12a", "koeln", "50739", nil, nil)
  end

  it "should recognize a city with a state in long form" do
    check_parsing_result(subject.parse("Köln, Nordrhein-Westfalen"),
                         nil, nil, "koeln", nil, "nordrhein-westfalen", nil)
  end

  it "should recognize a city with a state in short form" do
    check_parsing_result(subject.parse("Köln, NRW"),
                         nil, nil, "koeln", nil, "nrw", nil)
  end

  it "should recognize city if only city is present" do
    check_parsing_result(subject.parse("Köln"),
                         nil, nil, "koeln", nil, nil, nil)
  end

  it "should throw exception if not parseable shit is thrown at it" do
    pending "Not implemened yet"
    expect { subject.parse("diesistkeinestrasseundschmeissteineexception") }.to raise_error
  end
end
