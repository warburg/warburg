class EnlargeCalenderSummaryForCdbEventDetails < ActiveRecord::Migration
  def self.up
    change_column :cdb_event_details, :calendarsummary, :string, :limit => 600
  end

  def self.down
    change_column :cdb_event_details, :calendarsummary, :string, :limit => 255
  end
end
