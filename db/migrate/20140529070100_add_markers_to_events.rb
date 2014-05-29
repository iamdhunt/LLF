class AddMarkersToEvents < ActiveRecord::Migration
  def change
    add_column :events, :markers, :text
  end
end
