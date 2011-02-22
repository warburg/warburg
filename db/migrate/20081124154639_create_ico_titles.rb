class CreateIcoTitles < ActiveRecord::Migration
  def self.up
    create_table :ico_titles do |t|
      t.integer :ico_type_id
      t.string :title
      t.string :description
      t.date :date
      t.string :season
      t.integer :part_of_ico_title_id
      t.string :copyright
      t.integer :donation_id
      t.integer :archive_part_id
      t.integer :number_of_objects
      t.string :library_location
      t.boolean :available
      t.string :note

      t.timestamps
      t.userstamps
    end
  end

  def self.down
    drop_table :ico_titles
  end
end
