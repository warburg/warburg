class AddCityAndCountryToPerson < ActiveRecord::Migration
  def self.up
    add_column :people, :country_id, :integer
    add_column :people, :city, :string
  end

  def self.down
    remove_column :people, :city
    remove_column :people, :country_id
  end
end
