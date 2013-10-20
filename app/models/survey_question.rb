class SurveyQuestion < ActiveRecord::Base
  belongs_to :survey
  has_many :survey_responses, dependent: :destroy
  has_many :users, through: :survey_responses
  accepts_nested_attributes_for :survey_responses, reject_if: proc { |a| a[:response].blank? }

  MULT_CHOICE = "1"
  TEXT_RESPONSE = "2"

  QUESTION_TYPES = {
    MULT_CHOICE => "Multiple Choice",
    TEXT_RESPONSE => "Text Response"
  }

  def self.question_types
    return QUESTION_TYPES
  end

  def is_multiple_choice?
    return self.question_type == MULT_CHOICE
  end

  def is_text_response?
    return self.question_type == TEXT_RESPONSE
  end

  def responses_list_array
    return self.response_list.split(",")
  end

  def responses_for_value(val)
    return self.survey_responses.select{|response| response.response == val}
  end

end