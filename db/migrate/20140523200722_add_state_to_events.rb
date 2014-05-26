class AddStateToEvents < ActiveRecord::Migration
  def change
  	add_column :events, :state, :text
    add_column :events, :country, :text
  end
end
