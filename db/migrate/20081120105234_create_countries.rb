class CreateCountries < ActiveRecord::Migration
  def self.up
    create_table :countries do |t|
      t.string :iso_code, :limit => 2
      t.string :english
      t.string :dutch
      t.string :french

      t.timestamps
      t.userstamps
    end
  end

  def self.down
    drop_table :countries
  end
end
