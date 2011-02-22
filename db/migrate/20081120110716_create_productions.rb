class CreateProductions < ActiveRecord::Migration
  def self.up
    create_table :productions do |t|
      t.string :title
      t.string :inspiration_number
      t.string :season
      t.string :target_audience_text
      t.integer :target_audience_from
      t.integer :target_audience_to
      t.integer :revival_of_id
      t.boolean :verified
      t.string :note, :limit => 600

      t.timestamps
      t.userstamps
    end
  end

  def self.down
    drop_table :productions
  end
end
