class CreateOrganisationTypes < ActiveRecord::Migration
  def self.up
    create_table :organisation_types do |t|
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :organisation_types
  end
end
