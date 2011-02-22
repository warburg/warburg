class CreateEphemera < ActiveRecord::Migration
  def self.up
    create_table :ephemera do |t|
      t.integer :ephemerum_type_id
      t.string :title
      t.integer :source_id
      t.integer :donation_id
      t.integer :warehouse_id
      t.date :date
      t.string :season
      t.string :library_location
      t.boolean :available
      t.string :note

      t.timestamps
      t.userstamps
    end
  end

  def self.down
    drop_table :ephemera
  end
end
