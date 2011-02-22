class RemoveObsoleteFieldsFromCdbEvents < ActiveRecord::Migration
  def self.up
    remove_column :cdb_events, :title_fr
    remove_column :cdb_events, :title_nl
    remove_column :cdb_events, :long_description_fr
    remove_column :cdb_events, :long_description_nl
    remove_column :cdb_events, :short_description_fr
    remove_column :cdb_events, :short_description_nl
  end

  def self.down
    add_column :cdb_events, :short_description_nl, :string, :limit => 600
    add_column :cdb_events, :short_description_fr, :string, :limit => 600
    add_column :cdb_events, :long_description_nl, :text
    add_column :cdb_events, :long_description_fr, :text
    add_column :cdb_events, :title_nl, :string
    add_column :cdb_events, :title_fr, :string
  end
end
