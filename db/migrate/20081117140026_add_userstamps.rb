class AddUserstamps < ActiveRecord::Migration
  def self.up
    add_column :users, :creator_id, :integer
    add_column :users, :updater_id, :integer
    add_column :languages, :creator_id, :integer
    add_column :languages, :updater_id, :integer
    add_column :genders, :creator_id, :integer
    add_column :genders, :updater_id, :integer
    remove_column :organisations, :legal_form_id
    drop_table :legal_forms
    remove_column :organisations, :grant_status_id 
    drop_table :grant_statuses
    remove_column :organisations, :organisation_type_id
    drop_table :organisation_types
    add_column :people, :creator_id, :integer
    add_column :people, :updater_id, :integer
    add_column :person_versions, :creator_id, :integer
    add_column :person_versions, :updater_id, :integer
    add_column :organisation_properties, :creator_id, :integer
    add_column :organisation_properties, :updater_id, :integer
    add_column :organisations, :creator_id, :integer
    add_column :organisations, :updater_id, :integer
    add_column :organisation_versions, :creator_id, :integer
    add_column :organisation_versions, :updater_id, :integer
    add_column :donations, :creator_id, :integer
    add_column :donations, :updater_id, :integer
    add_column :serials, :creator_id, :integer
    add_column :serials, :updater_id, :integer
    add_column :impressums, :creator_id, :integer
    add_column :impressums, :updater_id, :integer
  end

  def self.down
    remove_column :impressums, :updater_id
    remove_column :impressums, :creator_id
    remove_column :serials, :updater_id
    remove_column :serials, :creator_id
    remove_column :donations, :updater_id
    remove_column :donations, :creator_id
    remove_column :organisation_versions, :updater_id
    remove_column :organisation_versions, :creator_id
    remove_column :organisations, :updater_id
    remove_column :organisations, :creator_id
    remove_column :organisation_properties, :updater_id
    remove_column :organisation_properties, :creator_id
    remove_column :person_versions, :updater_id
    remove_column :person_versions, :creator_id
    remove_column :people, :updater_id
    remove_column :people, :creator_id
    
    create_table "organisation_types", :force => true do |t|
      t.string   "description"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    
    add_column :organisations, :organisation_type_id, :integer

    create_table "grant_statuses", :force => true do |t|
      t.string   "code"
      t.string   "description"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_column :organisations, :grant_status_id, :integer
    create_table "legal_forms", :force => true do |t|
      t.string   "dutch"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    
    add_column :organisations, :legal_form_id, :integer
    remove_column :genders, :updater_id
    remove_column :genders, :creator_id
    remove_column :languages, :updater_id
    remove_column :languages, :creator_id
    remove_column :users, :updater_id
    remove_column :users, :creator_id
  end
end
