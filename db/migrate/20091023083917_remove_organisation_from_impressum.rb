class RemoveOrganisationFromImpressum < ActiveRecord::Migration
  def self.up
    remove_column :impressums, :organisation_id
  end

  def self.down
    add_column :impressums, :organisation_id, :integer
  end
end
