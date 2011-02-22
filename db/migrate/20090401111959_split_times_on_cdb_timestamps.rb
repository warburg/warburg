class SplitTimesOnCdbTimestamps < ActiveRecord::Migration
  def self.up
    remove_column :cdb_timestamps, :start
    add_column :cdb_timestamps, :date, :date
    add_column :cdb_timestamps, :timestart, :time
    add_column :cdb_timestamps, :timeend, :time
  end

  def self.down
    remove_column :cdb_timestamps, :date
    remove_column :cdb_timestamps, :timestart
    remove_column :cdb_timestamps, :timeend
    add_column :cdb_timestamps, :start, :datetime
  end
end
