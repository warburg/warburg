class CreateBoxTypes < ActiveRecord::Migration
  def self.up
    create_table :box_types do |t|
      t.string :description

      t.timestamps
      t.userstamps
    end
  end

  def self.down
    drop_table :box_types
  end
end
