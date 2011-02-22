class CreateOrganisationRelations < ActiveRecord::Migration
  def self.up
    create_table :organisation_relations do |t|
      t.integer :from_id
      t.integer :to_id
      t.integer :organisation_relation_type_id

      t.timestamps
      t.userstamps
    end
  end

  def self.down
    drop_table :organisation_relations
  end
end
