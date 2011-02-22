class AddCountryAndCityToOrganisationVersion < ActiveRecord::Migration
  def self.up
    add_column :organisation_versions, :country_id, :integer
    add_column :organisation_versions, :city, :string
  end

  def self.down
    remove_column :organisation_versions, :city
    remove_column :organisation_versions, :country_id
  end
end
