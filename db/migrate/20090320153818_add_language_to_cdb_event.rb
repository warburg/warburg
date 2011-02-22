class AddLanguageToCdbEvent < ActiveRecord::Migration
  def self.up
    add_column :cdb_events, :language_id, :integer
    add_column :cdb_events, :cdb_organisation_id, :integer
  end

  def self.down
    remove_column :cdb_events, :language_id
    remove_column :cdb_events, :cdb_organisation_id
  end
end
