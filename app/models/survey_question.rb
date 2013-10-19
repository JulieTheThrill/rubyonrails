class SurveyQuestion < ActiveRecord::Base
  belongs_to :survey
  has_many :survey_responses, dependent: :destroy

  MULT_CHOICE = 1
  TEXT_RESPONSE = 2

  QUESTION_TYPES = {
    MULT_CHOICE => "Multiple Choice",
    TEXT_RESPONSE => "Text Response"
  }

  def self.question_types
    return QUESTION_TYPES
  end

  def is_multiple_choice?
    return self.question_type == MULT_CHOICE.to_s
  end

  def is_text_response?
    return self.question_type == TEXT_RESPONSE.to_s
  end

end