class CreateOrganisationProperties < ActiveRecord::Migration
  def self.up
    create_table :organisation_properties do |t|
      t.integer :organisation_id
      t.integer :property_id

      t.timestamps
    end
  end

  def self.down
    drop_table :organisation_properties
  end
end
