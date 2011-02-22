class CreatePeriodicalCopies < ActiveRecord::Migration
  def self.up
    create_table :periodical_copies do |t|
      t.string :title
      t.integer :periodical_id
      t.string :volume
      t.string :number
      t.string :date_text
      t.date :search_date
      t.string :library_location
      t.integer :warehouse_id
      t.boolean :available
      t.integer :donation_id
      t.string :note
      t.integer :part_of_copy_id

      t.timestamps
      t.userstamps
    end
  end

  def self.down
    drop_table :periodical_copies
  end
end
