class CreateIcoTypes < ActiveRecord::Migration
  def self.up
    create_table :ico_types do |t|
      t.string :name

      t.timestamps
      t.userstamps
    end
  end

  def self.down
    drop_table :ico_types
  end
end
