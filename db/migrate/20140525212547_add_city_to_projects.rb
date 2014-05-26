class AddCityToProjects < ActiveRecord::Migration
  def change
  	add_column :projects, :city, :text
  end
end
