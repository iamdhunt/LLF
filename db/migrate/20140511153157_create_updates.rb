class CreateUpdates < ActiveRecord::Migration
  def change
    create_table :updates do |t|
      t.text :content
      t.string :title
      t.belongs_to :updateable, polymorphic: true
      t.references :member

      t.timestamps
    end
    add_index :updates, [:updateable_id, :updateable_type]
    add_index :updates, :member_id
  end
end
