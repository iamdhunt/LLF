class RemoveColumns < ActiveRecord::Migration
  def up
  	remove_column :statuses, :permalink
  	remove_column :media, :permalink
  	remove_column :events, :permalink
  	remove_column :projects, :permalink
  	remove_column :listings, :permalink
  end

  def down
  	add_column :statuses, :permalink, :string
  	add_column :media, :permalink, :string
  	add_column :projects, :permalink, :string
  	add_column :events, :permalink, :string
  	add_column :listings, :permalink, :string
  end
end
