class AddDateIsaarsToOrganisationRelation < ActiveRecord::Migration
  def self.up
    add_column :organisation_relations, :creation_date_id, :integer
    add_column :organisation_relations, :cancellation_date_id, :integer
    add_column :organisation_relations, :start_activities_date_id, :integer
    add_column :organisation_relations, :end_activities_date_id, :integer
  end

  def self.down
    remove_column :organisation_relations, :end_activities_date_id
    remove_column :organisation_relations, :start_activities_date_id
    remove_column :organisation_relations, :cancellation_date_id
    remove_column :organisation_relations, :creation_date_id
  end
end
