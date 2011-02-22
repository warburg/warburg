class AddCountryToPersonVersion < ActiveRecord::Migration
  def self.up
    add_column :person_versions, :country_id, :integer
    add_column :person_versions, :city, :string
  end

  def self.down
    remove_column :person_versions, :city
    remove_column :person_versions, :country_id
  end
end
