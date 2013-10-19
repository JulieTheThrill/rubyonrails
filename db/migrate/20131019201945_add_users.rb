class AddUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :first_name
      t.string :last_name
      t.string :u_number
      t.string :email
      t.text   :password_digest
      t.string :role, default: "student"
      t.timestamps
    end
  end
end
