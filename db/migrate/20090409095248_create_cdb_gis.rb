class CreateCdbGis < ActiveRecord::Migration
  def self.up
    create_table :cdb_gis do |t|
      t.integer :cdb_physical_address_id
      t.string :xcoordinate
      t.string :ycoordinate

      t.timestamps
    end
  end

  def self.down
    drop_table :cdb_gis
  end
end
