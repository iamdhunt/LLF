class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.references :member
      t.text :title
      t.text :link
      t.text :category
      t.text :subcategory
      t.text :description
      t.decimal :price, :precision => 8, :scale => 2

      t.timestamps
    end
    add_index :listings, :member_id
    add_attachment :listings, :feature
    add_attachment :listings, :image
  end
end
