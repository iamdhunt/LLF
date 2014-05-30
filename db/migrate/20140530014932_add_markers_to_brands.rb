class AddMarkersToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :markers, :text
  end
end
