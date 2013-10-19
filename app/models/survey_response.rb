class SurveyResponse < ActiveRecord::Base
  belongs_to :survey_question
  has_one :user
end