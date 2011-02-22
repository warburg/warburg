class AddOrganisationRelationsToRelationships < ActiveRecord::Migration
  def self.up
    add_column :relationships, :organisation_from_id,          :integer
    add_column :relationships, :organisation_to_id,            :integer
    add_column :relationships, :organisation_relation_type_id, :integer
    add_column :relationships, :creation_date_id,              :integer
    add_column :relationships, :cancellation_date_id,          :integer
    add_column :relationships, :start_activities_date_id,      :integer
    add_column :relationships, :end_activities_date_id,        :integer
    
    Old::OrganisationRelation.all.each do |organisation_relation|
      OrganisationRelation.create({
        :organisation_from_id          => organisation_relation.from_id,
        :organisation_to_id            => organisation_relation.to_id,
        :organisation_relation_type_id => organisation_relation.organisation_relation_type_id
      })
    end
  end

  def self.down
    remove_column :relationships, :end_activities_date_id
    remove_column :relationships, :start_activities_date_id
    remove_column :relationships, :cancellation_date_id
    remove_column :relationships, :creation_date_id
    remove_column :relationships, :organisation_relation_type_id
    remove_column :relationships, :organisation_to_id
    remove_column :relationships, :organisation_from_id
  end
end
