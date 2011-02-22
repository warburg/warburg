class CreateOrganisationRelationTypes < ActiveRecord::Migration
  def self.up
    create_table :organisation_relation_types do |t|
      t.string :from_name
      t.string :to_name

      t.timestamps
      t.userstamps
    end
  end

  def self.down
    drop_table :organisation_relation_types
  end
end
