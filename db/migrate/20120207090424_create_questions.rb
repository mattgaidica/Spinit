class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :body
      t.integer :topic_id
      t.integer :answer_id

      t.timestamps
    end
  end
end
