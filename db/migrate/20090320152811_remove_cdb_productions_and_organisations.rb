class RemoveCdbProductionsAndOrganisations < ActiveRecord::Migration
  def self.up
    drop_table :cdb_productions

    add_column :cdb_organisations, :cdbid, :string
    
    add_column :cdb_events, :title_fr, :string
    add_column :cdb_events, :title_nl, :string
    add_column :cdb_events, :long_description_fr, :string
    add_column :cdb_events, :long_description_nl, :string
    add_column :cdb_events, :short_description_fr, :string
    add_column :cdb_events, :short_description_nl, :string
  end

  def self.down
    remove_column :cdb_events, :title_fr
    remove_column :cdb_events, :title_nl
    remove_column :cdb_events, :long_description_fr
    remove_column :cdb_events, :long_description_nl
    remove_column :cdb_events, :short_description_fr
    remove_column :cdb_events, :short_description_nl

    create_table :cdb_productions do |t|
      t.string :title
      t.text :long_description_nl
      t.text :long_description_fr
      t.string :short_description_nl
      t.string :short_description_fr
      t.integer :language_id
      t.integer :cdb_organisation_id

      t.timestamps
    end

    remove_column :cdb_organisations, :cdbid

  end
end
