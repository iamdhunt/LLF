class CreateMentions < ActiveRecord::Migration
    def change
      create_table :mentions do |t|
        t.belongs_to :mentionable, polymorphic: true
        t.belongs_to :mentioner, polymorphic: true
        t.timestamps
      end
      add_index :mentions, [:mentionable_id, :mentionable_type], :name => "ments_on_ables_id_and_type"
      add_index :mentions, [:mentioner_id, :mentioner_type], :name => "ments_on_ers_id_and_type"
    end
end