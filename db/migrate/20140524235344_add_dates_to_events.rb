class AddDatesToEvents < ActiveRecord::Migration
  def change
  	add_column :events, :start_date, :datetime
    add_column :events, :end_date, :datetime
    add_column :events, :start_time, :datetime
    add_column :events, :end_time, :datetime
  end
end
