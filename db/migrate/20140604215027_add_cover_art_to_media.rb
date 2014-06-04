class AddCoverArtToMedia < ActiveRecord::Migration
  def change
  	add_attachment :media, :cover
  end
end
