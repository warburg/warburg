class AddViewFieldsToOrganisations < ActiveRecord::Migration
  def self.up
    add_column :organisations, :views, :integer
    add_column :organisations, :viewed_at, :datetime
    add_column :organisation_versions, :views, :integer
    add_column :organisation_versions, :viewed_at, :datetime
  end

  def self.down
    remove_column :organisations, :views
    remove_column :organisations, :viewed_at
    remove_column :organisation_versions, :views
    remove_column :organisation_versions, :viewed_at
  end
end
