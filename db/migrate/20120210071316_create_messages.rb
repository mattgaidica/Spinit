class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.text :body
      t.integer :page_id

      t.timestamps
    end
  end
end
