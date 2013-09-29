class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.references :member
      t.text :caption

      t.timestamps
    end
    add_index :media, :member_id
    add_attachment :media, :asset
  end
end
