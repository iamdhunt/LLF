class AddIdsToMentions < ActiveRecord::Migration
  def change
    add_column :mentions, :status_id, :integer
    add_column :mentions, :comment_id, :integer
    add_column :mentions, :member_id, :integer
  end
end
