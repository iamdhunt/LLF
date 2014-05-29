class RemoveTagsFromEvents < ActiveRecord::Migration
  def up
    remove_column :events, :tags
  end

  def down
    add_column :events, :tags, :text
  end
end
