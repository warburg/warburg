class CreateGrants < ActiveRecord::Migration
  def self.up
    create_table :grants do |t|
      t.integer :grant_state_id
      t.integer :grant_system_id
      t.integer :person_id
      t.integer :organisation_id
      t.date :date
      t.string :period
      t.integer :production_id
      t.string :note

      t.timestamps
      t.userstamps
    end
  end

  def self.down
    drop_table :grants
  end
end
