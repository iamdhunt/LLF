class AddTestToProjects < ActiveRecord::Migration
  def change
  	add_column :projects, :test, :string
  	add_column :projects, :test_html, :string
  end
end
