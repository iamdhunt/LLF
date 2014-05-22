class AddLocationToEvents < ActiveRecord::Migration
  def change
  	add_column :events, :location, :text
    add_column :events, :address, :text
    add_column :events, :city, :text
    add_column :events, :zipcode, :string
  end
end
