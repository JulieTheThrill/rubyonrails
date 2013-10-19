class AddSurveyQuestions < ActiveRecord::Migration
  def change
    create_table :survey_questions do |t|
      t.integer :survey_id
      t.string :question
      t.string :question_type

      t.timestamps
    end
  end
end

