class CreateOrganisationPersonLinks < ActiveRecord::Migration
  def self.up
    create_table :organisation_person_links do |t|
      t.integer :organisation_id
      t.integer :person_id
      t.integer :role_id
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end

  def self.down
    drop_table :organisation_person_links
  end
end
