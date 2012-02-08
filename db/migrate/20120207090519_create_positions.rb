class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.string :latitude
      t.string :longitude
      t.integer :user_id

      t.timestamps
    end
  end
end
