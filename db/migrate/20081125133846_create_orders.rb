class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.integer :organisation_id
      t.date :date
      t.string :type
      t.boolean :sent
      t.string :order_number

      t.timestamps
      t.userstamps
    end
  end

  def self.down
    drop_table :orders
  end
end
