class AddDescrToProductionVersions < ActiveRecord::Migration
  def self.up
    add_column :production_versions, :description_nl, :text
    add_column :production_versions, :description_fr, :text
    add_column :production_versions, :description_en, :text
  end

  def self.down
    remove_column :production_versions, :description_en
    remove_column :production_versions, :description_fr
    remove_column :production_versions, :description_nl
  end
end
