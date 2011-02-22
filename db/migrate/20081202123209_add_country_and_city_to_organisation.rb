class AddCountryAndCityToOrganisation < ActiveRecord::Migration
  def self.up
    add_column :organisations, :country_id, :integer
    add_column :organisations, :city, :string
  end

  def self.down
    remove_column :organisations, :city
    remove_column :organisations, :country_id
  end
end
