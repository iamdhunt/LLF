class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.belongs_to :uploadable, polymorphic: true
      t.references :member

      t.timestamps
    end
    add_index :uploads, [:uploadable_id, :uploadable_type]
    add_index :uploads, :member_id
    add_attachment :uploads, :asset
  end
end
