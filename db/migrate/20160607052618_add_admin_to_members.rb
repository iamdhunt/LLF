class AddAdminToMembers < ActiveRecord::Migration
  def change
    add_column :members, :admin, :boolean
    add_column :members, :verified, :boolean
  end
end
