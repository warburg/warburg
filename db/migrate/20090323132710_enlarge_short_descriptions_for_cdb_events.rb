class EnlargeShortDescriptionsForCdbEvents < ActiveRecord::Migration
  def self.up
    change_column :cdb_events, :short_description_nl, :string, :limit => 600
    change_column :cdb_events, :short_description_fr, :string, :limit => 600
  end

  def self.down
    change_column :cdb_events, :short_description_nl, :string, :limit => 255
    change_column :cdb_events, :short_description_fr, :string, :limit => 255
  end
end
