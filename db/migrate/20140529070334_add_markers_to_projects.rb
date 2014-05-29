class AddMarkersToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :markers, :text
  end
end
