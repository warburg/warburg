class CreateCdbActors < ActiveRecord::Migration
  def self.up
    create_table :cdb_actors do |t|
      t.string :cdbid
      t.string :externalid
      t.boolean :person
      t.boolean :private
      t.string :label

      t.timestamps
    end
  end

  def self.down
    drop_table :cdb_actors
  end
end
