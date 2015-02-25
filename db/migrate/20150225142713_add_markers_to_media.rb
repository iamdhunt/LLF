class AddMarkersToMedia < ActiveRecord::Migration
  def change
    add_column :media, :markers, :text
  end
end
