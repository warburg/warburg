class CreatePeriodicalLanguages < ActiveRecord::Migration
  def self.up
    create_table :periodical_languages do |t|
      t.integer :periodical_id
      t.integer :language_id
      t.string :language_note

      t.timestamps
      t.userstamps
    end
  end

  def self.down
    drop_table :periodical_languages
  end
end
