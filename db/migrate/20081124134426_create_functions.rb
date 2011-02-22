class CreateFunctions < ActiveRecord::Migration
  def self.up
    create_table :functions do |t|
      t.string :name
      t.string :type
      t.string :marc
      t.string :marc_code

      t.timestamps
      t.userstamps
    end
  end

  def self.down
    drop_table :functions
  end
end
