module SurveysHelper

  def prettify(text)
    text.gsub("_", " ").capitalize
  end
end
