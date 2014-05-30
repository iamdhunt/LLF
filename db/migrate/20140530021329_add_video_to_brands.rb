class AddVideoToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :video, :text
  end
end
