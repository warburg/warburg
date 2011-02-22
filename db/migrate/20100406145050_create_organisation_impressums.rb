class CreateOrganisationImpressums < ActiveRecord::Migration
  def self.up
    create_table :organisation_impressums do |t|
      t.integer :organisation_id
      t.integer :impressum_id

      t.timestamps
      t.userstamps
    end
    
    add_index :organisation_impressums, :organisation_id, :name => "index_organisation_impressums_on_organisation_id"
  end

  def self.down
    drop_table :organisation_impressums
  end
end
