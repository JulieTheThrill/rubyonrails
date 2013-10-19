class Survey < ActiveRecord::Base
  has_many :survey_questions, dependent: :destroy
  accepts_nested_attributes_for :survey_questions, reject_if: proc { |a| a[:question].blank? }, allow_destroy: true
end
