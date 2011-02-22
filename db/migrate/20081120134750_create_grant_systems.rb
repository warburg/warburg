class CreateGrantSystems < ActiveRecord::Migration
  def self.up
    create_table :grant_systems do |t|
      t.string :code
      t.string :description
      t.string :legal_base
      t.string :type
      t.integer :grant_genre_id
      t.string :organisation_form
      t.string :note

      t.timestamps
      t.userstamps
    end
  end

  def self.down
    drop_table :grant_systems
  end
end
