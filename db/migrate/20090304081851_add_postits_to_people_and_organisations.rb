class AddPostitsToPeopleAndOrganisations < ActiveRecord::Migration
  def self.up
    add_column :postits, :person_id, :integer
    add_column :postits, :organisation_id, :integer
  end

  def self.down
    remove_column :postits, :person_id
    remove_column :postits, :organisation_id
  end
end
