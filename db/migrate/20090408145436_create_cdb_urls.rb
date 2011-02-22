class CreateCdbUrls < ActiveRecord::Migration
  def self.up
    create_table :cdb_urls do |t|
      t.integer :cdb_contactinfo_id
      t.boolean :main
      t.boolean :reservation
      t.string :url

      t.timestamps
    end
  end

  def self.down
    drop_table :cdb_urls
  end
end
