class CreateDateIsaars < ActiveRecord::Migration
  def self.up
    create_table :date_isaars do |t|
      t.string :exact_date
      t.integer :day
      t.integer :month
      t.integer :year
      t.string :state
      t.string :source
      t.string :note
      t.timestamps
      t.userstamps
    end
    
    add_column :people, :birthdate_id, :integer
    add_column :people, :death_date_id, :integer
    add_column :person_versions, :birthdate_id, :integer
    add_column :person_versions, :death_date_id, :integer
    add_column :organisations, :creation_date_id, :integer
    add_column :organisations, :cancellation_date_id, :integer
    add_column :organisations, :start_activities_date_id, :integer
    add_column :organisations, :end_activities_date_id, :integer
    add_column :organisation_versions, :creation_date_id, :integer
    add_column :organisation_versions, :cancellation_date_id, :integer
    add_column :organisation_versions, :start_activities_date_id, :integer
    add_column :organisation_versions, :end_activities_date_id, :integer
  end

  def self.down
    remove_column :organisation_versions, :end_activities_date_id
    remove_column :organisation_versions, :start_activities_date_id
    remove_column :organisation_versions, :cancellation_date_id
    remove_column :organisation_versions, :creation_date_id
    remove_column :person_versions, :death_date_id
    remove_column :person_versions, :birthdate_id
    remove_column :organisations, :end_activities_date_id
    remove_column :organisations, :start_activities_date_id
    remove_column :organisations, :cancellation_date_id
    remove_column :organisations, :creation_date_id
    remove_column :people, :death_date_id
    remove_column :people, :birthdate_id
    drop_table :date_isaars
  end
end
