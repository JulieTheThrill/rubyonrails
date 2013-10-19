module SurveyQuestionsHelper

  def type_options
    types = []
    SurveyQuestion.question_types.each do |int, text|
      types << [text, int]
    end
    types
  end
end
