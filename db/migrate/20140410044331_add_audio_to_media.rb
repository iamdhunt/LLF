class AddAudioToMedia < ActiveRecord::Migration
  def change
  	add_attachment :media, :audio
  end
end
