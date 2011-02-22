class DropOrganisationProperties < ActiveRecord::Migration
  def self.up
    drop_table :organisation_properties
  end

  def self.down
    create_table "organisation_properties", :force => true do |t|
      t.integer  "organisation_id"
      t.integer  "property_id"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "creator_id"
      t.integer  "updater_id"
    end
    
  end
end
