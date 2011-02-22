class AddMultiLanguageToIcoTitle < ActiveRecord::Migration
  def self.up
    rename_column :ico_titles, :description, :description_nl
    add_column :ico_titles, :description_fr, :string
    add_column :ico_titles, :description_en, :string
  end

  def self.down
    rename_column :ico_titles, :description_nl, :description
    remove_column :ico_titles, :description_fr
    remove_column :ico_titles, :description_en
  end
end
