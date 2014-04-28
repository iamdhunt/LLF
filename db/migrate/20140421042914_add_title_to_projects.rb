class AddTitleToProjects < ActiveRecord::Migration
  def change
  	add_column :projects, :title, :text
  end
end
