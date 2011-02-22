class AddMultilanguageDescriptionsToDocumentTypes < ActiveRecord::Migration
  def self.up
    rename_column :document_types, :description, :description_nl
    add_column :document_types, :description_fr, :string
    add_column :document_types, :description_en, :string
  end

  def self.down
    rename_column :document_types, :description_nl, :description
    remove_column :document_types, :description_fr
    remove_column :document_types, :description_en
  end
end
