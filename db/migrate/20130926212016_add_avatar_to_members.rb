class AddAvatarToMembers < ActiveRecord::Migration
  def change
  	add_attachment :members, :avatar
  end
end
