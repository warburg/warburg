class RenameCountryFields < ActiveRecord::Migration
  def self.up
    rename_column :countries, :dutch, :name_nl
    rename_column :countries, :english, :name_en
    rename_column :countries, :french, :name_fr
  end

  def self.down
    rename_column :countries, :name_nl, :dutch
    rename_column :countries, :name_en, :english
    rename_column :countries, :name_fr, :french
  end
end
