class AddMultiLanguageToBoxTypes < ActiveRecord::Migration
  def self.up
    rename_column :box_types, :description, :description_nl
    add_column :box_types, :description_fr, :string
    add_column :box_types, :description_en, :string
  end

  def self.down
    rename_column :box_types, :description_nl, :description
    remove_column :box_types, :description_fr
    remove_column :box_types, :description_en
  end
end
