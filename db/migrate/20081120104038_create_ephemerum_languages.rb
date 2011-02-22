class CreateEphemerumLanguages < ActiveRecord::Migration
  def self.up
    create_table :ephemerum_languages do |t|
      t.integer :ephemerum_id
      t.integer :language_id
      t.string :note

      t.timestamps
      t.userstamps
    end
  end

  def self.down
    drop_table :ephemerum_languages
  end
end
