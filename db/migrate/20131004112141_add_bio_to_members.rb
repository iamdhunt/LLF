class AddBioToMembers < ActiveRecord::Migration
  def change
    add_column :members, :bio, :text
    add_column :members, :city, :string
    add_column :members, :state, :string
    add_column :members, :country, :string
  end
end
