class AddBannerToMembers < ActiveRecord::Migration
  def change
  	add_attachment :members, :banner
  end
end
