class CreateWarehouses < ActiveRecord::Migration
  def self.up
    create_table :warehouses do |t|
      t.integer :box_type_id
      t.string :box_location

      t.timestamps
      t.userstamps
    end
  end

  def self.down
    drop_table :warehouses
  end
end
