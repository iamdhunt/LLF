class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
    	t.integer :member_id
      	t.timestamps
    end

    	add_index :documents, :member_id
    	add_attachment :documents, :attachment
    	add_column :statuses, :document_id, :integer
  end
end
