class CreateEphemerumTypes < ActiveRecord::Migration
  def self.up
    create_table :ephemerum_types do |t|
      t.string :name
      t.string :description

      t.timestamps
      t.userstamps
    end
  end

  def self.down
    drop_table :ephemerum_types
  end
end
