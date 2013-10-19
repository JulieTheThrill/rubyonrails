class AddSurveyResponsesToDatabase < ActiveRecord::Migration
  def change
    create_table :survey_responses do |t|
      t.integer :question_id
      t.string :user_id
      t.text :response

      t.timestamps
    end
  end
end
