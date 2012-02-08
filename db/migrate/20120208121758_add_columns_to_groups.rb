class AddColumnsToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :question_id, :integer
    add_column :groups, :question_time, :datetime
    add_column :groups, :question_duration, :integer
  end
end
