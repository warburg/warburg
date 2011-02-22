class ExtraProductionFields < ActiveRecord::Migration
  def self.up
    add_column :productions, :external_id, :string
    add_column :productions, :number_by_country, :string
    add_column :productions, :library_location, :string
    add_column :production_versions, :external_id, :string
    add_column :production_versions, :number_by_country, :string
    add_column :production_versions, :library_location, :string
  end

  def self.down
    remove_column :production_versions, :library_location
    remove_column :production_versions, :number_by_country
    remove_column :production_versions, :external_id
    remove_column :productions, :library_location
    remove_column :productions, :number_by_country
    remove_column :productions, :external_id
  end
end
