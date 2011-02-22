class MakeOrganisationRelationsMultilingual < ActiveRecord::Migration
  def self.up
    rename_column :organisation_relation_types, :from_name, :from_name_nl
    rename_column :organisation_relation_types, :to_name, :to_name_nl
    add_column :organisation_relation_types, :from_name_fr, :string
    add_column :organisation_relation_types, :to_name_fr, :string
    add_column :organisation_relation_types, :from_name_en, :string
    add_column :organisation_relation_types, :to_name_en, :string
  end

  def self.down
    remove_column :organisation_relation_types, :from_name_fr
    remove_column :organisation_relation_types, :to_name_fr
    remove_column :organisation_relation_types, :from_name_en
    remove_column :organisation_relation_types, :to_name_en
    rename_column :organisation_relation_types, :from_name_nl, :from_name
    rename_column :organisation_relation_types, :to_name_nl, :to_name
  end
end
