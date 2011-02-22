class CreateAlumni < ActiveRecord::Migration
  def self.up
    create_table :alumni do |t|
      t.integer :organisation_id
      t.integer :person_id
      t.string :start_year
      t.string :end_year
      t.string :note

      t.timestamps
      t.userstamps
    end
  end

  def self.down
    drop_table :alumni
  end
end
