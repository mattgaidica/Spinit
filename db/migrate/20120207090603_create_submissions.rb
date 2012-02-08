class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.integer :group_id
      t.integer :question_id
      t.integer :user_id
      t.integer :answer_id

      t.timestamps
    end
  end
end
