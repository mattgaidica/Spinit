class CreateTakers < ActiveRecord::Migration
  def change
    create_table :takers do |t|
      t.integer :page_id
      t.integer :user_id
      t.integer :status

      t.timestamps
    end
  end
end
