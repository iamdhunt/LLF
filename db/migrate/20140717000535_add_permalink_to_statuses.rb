class AddPermalinkToStatuses < ActiveRecord::Migration
  def change
  	add_column :statuses, :permalink, :string
  end
end
