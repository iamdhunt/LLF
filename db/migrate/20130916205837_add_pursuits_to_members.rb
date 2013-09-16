class AddPursuitsToMembers < ActiveRecord::Migration
  def change
    add_column :members, :pursuits, :string
  end
end
