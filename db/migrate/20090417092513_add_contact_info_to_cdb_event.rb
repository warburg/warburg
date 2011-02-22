class AddContactInfoToCdbEvent < ActiveRecord::Migration
  def self.up
    add_column :cdb_contactinfos, :cdb_event_id, :integer
  end

  def self.down
    remove_column :cdb_contactinfos, :cdb_event_id
  end
end
