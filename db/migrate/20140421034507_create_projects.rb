class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.references :member
      t.text :category
      t.text :tags
      t.text :website
      t.text :video
      t.text :about
      t.text :blurb

      t.timestamps
    end
    add_index :projects, :member_id
    add_attachment :projects, :banner
    add_attachment :projects, :avatar
  end
end
