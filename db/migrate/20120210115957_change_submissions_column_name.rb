class ChangeSubmissionsColumnName < ActiveRecord::Migration
  def change
    rename_column :submissions, :group_id, :page_id
  end
end
