class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.references :member
      t.references :listing

      t.timestamps
    end
    add_index :assets, :member_id
    add_index :assets, :listing_id
    add_attachment :assets, :asset
  end
end
