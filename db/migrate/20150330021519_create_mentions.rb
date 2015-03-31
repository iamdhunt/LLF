class CreateMentions < ActiveRecord::Migration
    def change
      create_table :mentions do |t|
        t.belongs_to :mentionable, polymorphic: true
        t.timestamps
      end
      add_index :mentions, [:mentionable_id, :mentionable_type]
    end
end