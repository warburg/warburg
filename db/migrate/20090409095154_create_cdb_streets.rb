class CreateCdbStreets < ActiveRecord::Migration
  def self.up
    create_table :cdb_streets do |t|
      t.string :street
      t.string :cdbid

      t.timestamps
    end
  end

  def self.down
    drop_table :cdb_streets
  end
end
