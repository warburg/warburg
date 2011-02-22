class AddPermalinkToCdbEvents < ActiveRecord::Migration
  def self.up
    add_column :cdb_events, :permalink, :string
  end

  def self.down
    remove_column :cdb_events, :permalink
  end
end
