class CreateCdbOrganisations < ActiveRecord::Migration
  def self.up
    create_table :cdb_organisations do |t|
      t.string :label

      t.timestamps
    end
  end

  def self.down
    drop_table :cdb_organisations
  end
end
