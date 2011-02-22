class CreateShows < ActiveRecord::Migration
  def self.up
    create_table :shows do |t|
      t.integer :production_id
      t.integer :show_type_id
      t.integer :room_id
      t.integer :organisation_id
      t.date :date
      t.string :time
      t.string :season
      t.string :premiere
      t.string :note

      t.timestamps
      t.userstamps
    end
  end

  def self.down
    drop_table :shows
  end
end
