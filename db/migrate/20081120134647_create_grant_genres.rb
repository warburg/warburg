class CreateGrantGenres < ActiveRecord::Migration
  def self.up
    create_table :grant_genres do |t|
      t.string :description
      t.string :note

      t.timestamps
      t.userstamps
    end
  end

  def self.down
    drop_table :grant_genres
  end
end
