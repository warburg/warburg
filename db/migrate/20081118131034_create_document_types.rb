class CreateDocumentTypes < ActiveRecord::Migration
  def self.up
    create_table :document_types do |t|
      t.string :description

      t.timestamps
      t.userstamps
    end
  end

  def self.down
    drop_table :document_types
  end
end
