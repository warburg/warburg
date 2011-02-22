class CreateCdbProductions < ActiveRecord::Migration
  def self.up
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
  end

  def self.down
    drop_table :cdb_productions
  end
end
