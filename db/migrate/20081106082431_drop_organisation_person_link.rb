class DropOrganisationPersonLink < ActiveRecord::Migration
  def self.up
    drop_table :organisation_person_links
  end

  def self.down
    create_table "organisation_person_links", :force => true do |t|
      t.integer  "organisation_id"
      t.integer  "person_id"
      t.integer  "role_id"
      t.date     "start_date"
      t.date     "end_date"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    
  end
end
