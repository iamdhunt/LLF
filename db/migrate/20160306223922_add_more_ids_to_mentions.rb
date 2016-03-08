class AddMoreIdsToMentions < ActiveRecord::Migration
  def change
    add_column :mentions, :medium_id, :integer
    add_column :mentions, :update_id, :integer
    add_column :mentions, :upload_id, :integer
    add_column :mentions, :event_id, :integer
    add_column :mentions, :project_id, :integer
  end
end
