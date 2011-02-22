class RemoveProductionIdFromCdbEvents < ActiveRecord::Migration
  def self.up
    remove_column :cdb_events, :cdb_production_id
  end


  def self.down
    add_column :cdb_events, :cdb_production_id, :integer
  end
end
