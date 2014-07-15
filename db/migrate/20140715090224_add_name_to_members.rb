class AddNameToMembers < ActiveRecord::Migration
  def change
  	add_column :members, :full_name, :string
  end
end
