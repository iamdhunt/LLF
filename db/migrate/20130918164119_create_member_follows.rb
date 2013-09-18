class CreateMemberFollows < ActiveRecord::Migration
  def change
    create_table :member_follows do |t|
    	t.integer :member_id
    	t.integer :follow_id
      	t.timestamps
    end

    add_index :member_follows, [:member_id, :follow_id]
  end
end
