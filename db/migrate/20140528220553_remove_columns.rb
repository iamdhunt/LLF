class RemoveColumns < ActiveRecord::Migration
  def self.up
  remove_column :projects, :tags
end

  def down
  end
end
