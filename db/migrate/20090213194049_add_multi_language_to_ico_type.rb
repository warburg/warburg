class AddMultiLanguageToIcoType < ActiveRecord::Migration
  def self.up
    rename_column :ico_types, :name, :description_nl
    add_column :ico_types, :description_fr, :string
    add_column :ico_types, :description_en, :string
  end

  def self.down
    rename_column :ico_types, :description_nl, :name
    remove_column :ico_types, :description_fr
    remove_column :ico_types, :description_en
  end
end
