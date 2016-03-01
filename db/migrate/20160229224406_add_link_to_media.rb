class AddLinkToMedia < ActiveRecord::Migration
  def change
    add_column :media, :link, :text
  end
end
