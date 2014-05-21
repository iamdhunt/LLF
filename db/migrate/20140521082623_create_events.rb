class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :member
      t.text :category
      t.text :tags
      t.text :website
      t.text :video
      t.text :details
      t.text :blurb
      t.text :name

      t.timestamps
    end
    add_index :events, :member_id
    add_attachment :events, :banner
    add_attachment :events, :avatar
  end
end
