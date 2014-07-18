class AddPermalinkToMedia < ActiveRecord::Migration
  def change
  	add_column :media, :permalink, :string
  end
end
