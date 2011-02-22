class CreateSeasons < ActiveRecord::Migration
  def self.up
    create_table :seasons, :force => true do |t|
      t.integer :start_year
      t.integer :end_year
      t.string :name
      t.timestamps
      t.userstamps
    end
  end

  def self.down
    drop_table :seasons
  end
end
