class AddCoverArtToUploads < ActiveRecord::Migration
  def change
  	add_attachment :uploads, :cover
  end
end
