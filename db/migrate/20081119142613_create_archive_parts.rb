class CreateArchiveParts < ActiveRecord::Migration
  def self.up
    create_table :archive_parts do |t|
      t.string :title
      t.integer :donation_id
      t.string :note
      t.integer :warehouse_id
      t.string :classification_code

      t.timestamps
      t.userstamps
    end
  end

  def self.down
    drop_table :archive_parts
  end
end
