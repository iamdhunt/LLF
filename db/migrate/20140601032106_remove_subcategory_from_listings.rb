class RemoveSubcategoryFromListings < ActiveRecord::Migration
  def up
    remove_column :listings, :subcategory
  end

  def down
    add_column :listings, :subcategory, :text
  end
end
