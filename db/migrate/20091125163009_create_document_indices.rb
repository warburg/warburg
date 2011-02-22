class CreateDocumentIndices < ActiveRecord::Migration
  def self.up
    create_table :document_indices do |t|
      t.string :key
      t.integer :document_id
      t.string :document_type

      t.timestamps
    end
    
    add_index :document_indices, :key
  end

  def self.down
    remove_index :document_indices, :key
    drop_table :document_indices
  end
end
