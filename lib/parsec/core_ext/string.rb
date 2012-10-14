# encoding: UTF-8

class String
  def normalize_for_parsec
    gsub("ä", "ae")
    .gsub("ü", "ue")
    .gsub("ö", "oe")
    .gsub("ß", "ss")
    .downcase
    .gsub("str.", "strasse")
    .gsub("pl.", "platz")
  end

  def normalize_for_parsec!
    gsub!("ä", "ae")
    gsub!("ü", "ue")
    gsub!("ö", "oe")
    gsub!("ß", "ss")
    downcase!
    gsub!("str.", "strasse")
    gsub!("pl.", "platz")
  end
end
