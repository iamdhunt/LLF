class AddPermalinkToActivities < ActiveRecord::Migration
  def change
  	add_column :activities, :targetable_permalink, :string
  	add_index :activities, :targetable_permalink
  end
end
