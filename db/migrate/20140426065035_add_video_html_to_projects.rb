class AddVideoHtmlToProjects < ActiveRecord::Migration
  def change
  	add_column :projects, :video_html, :text
  end
end
