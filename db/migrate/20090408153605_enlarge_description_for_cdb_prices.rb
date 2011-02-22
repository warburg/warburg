class EnlargeDescriptionForCdbPrices < ActiveRecord::Migration
  def self.up
    change_column :cdb_prices, :pricedescription, :string, :limit => 1000
  end

  def self.down
    change_column :cdb_prices, :pricedescription, :string, :limit => 255
  end
end
