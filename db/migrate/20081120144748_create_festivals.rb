class CreateFestivals < ActiveRecord::Migration
  def self.up
    create_table :festivals do |t|
      t.integer :organisation_id
      t.string :periodicity
      t.date :start
      t.string :start_text
      t.date :stop
      t.string :stop_text
      t.string :type
      t.string :note

      t.timestamps
      t.userstamps
    end
  end

  def self.down
    drop_table :festivals
  end
end
