class CreateCdbPrices < ActiveRecord::Migration
  def self.up
    create_table :cdb_prices do |t|
      t.float :pricevalue
      t.string :pricedescription
      t.integer :cdb_event_detail_id

      t.timestamps
    end

  end

  def self.down
    drop_table :cdb_prices
  end
end
