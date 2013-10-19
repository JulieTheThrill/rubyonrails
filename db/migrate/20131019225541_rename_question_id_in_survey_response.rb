class RenameQuestionIdInSurveyResponse < ActiveRecord::Migration
  def change
    rename_column :survey_responses, :question_id, :survey_question_id
  end
end
