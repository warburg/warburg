class CreateCdbCities < ActiveRecord::Migration
  def self.up
    create_table :cdb_cities do |t|
      t.string :cdbid
      t.string :city

      t.timestamps
    end
  end

  def self.down
    drop_table :cdb_cities
  end
end
