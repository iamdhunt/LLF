class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.references :member
      t.text :name
      t.text :description

      t.timestamps
    end
    add_index :brands, :member_id
    add_attachment :brands, :banner
    add_attachment :brands, :logo
  end
end
