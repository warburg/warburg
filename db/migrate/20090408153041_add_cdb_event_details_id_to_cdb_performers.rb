class AddCdbEventDetailsIdToCdbPerformers < ActiveRecord::Migration
  def self.up
    add_column :cdb_performers, :cdb_event_detail_id, :integer
  end

  def self.down
    remove_column :cdb_performers, :cdb_event_detail_id
  end
end
