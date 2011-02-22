class CreateShowTypes < ActiveRecord::Migration
  def self.up
    create_table :show_types do |t|
      t.string :name

      t.timestamps
      t.userstamps
    end
  end

  def self.down
    drop_table :show_types
  end
end
