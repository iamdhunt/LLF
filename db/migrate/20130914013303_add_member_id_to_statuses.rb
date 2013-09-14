class AddMemberIdToStatuses < ActiveRecord::Migration
  def change
  		add_column :statuses, :member_id, :integer
  		add_index :statuses, :member_id
  		remove_column :statuses, :name
  end
end
