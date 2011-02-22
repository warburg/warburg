class RenameLanguageFields < ActiveRecord::Migration
  def self.up
    rename_column :languages, :dutch, :name_nl
    rename_column :languages, :english, :name_en
    rename_column :languages, :french, :name_fr
  end

  def self.down
    rename_column :languages, :name_nl, :dutch
    rename_column :languages, :name_en, :english
    rename_column :languages, :name_fr, :french
  end
end
