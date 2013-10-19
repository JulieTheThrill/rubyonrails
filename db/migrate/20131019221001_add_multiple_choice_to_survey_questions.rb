class AddMultipleChoiceToSurveyQuestions < ActiveRecord::Migration
  def change
    add_column :survey_questions, :response_list, :text
  end
end
