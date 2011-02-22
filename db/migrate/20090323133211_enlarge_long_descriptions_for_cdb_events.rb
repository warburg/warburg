class EnlargeLongDescriptionsForCdbEvents < ActiveRecord::Migration
  def self.up
    change_column :cdb_events, :long_description_nl, :text
    change_column :cdb_events, :long_description_fr, :text
  end

  def self.down
    change_column :cdb_events, :long_description_nl, :string, :limit => 255
    change_column :cdb_events, :long_description_fr, :string, :limit => 255
  end
end
