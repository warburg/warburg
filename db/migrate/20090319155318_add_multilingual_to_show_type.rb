class AddMultilingualToShowType < ActiveRecord::Migration
  def self.up
    rename_column :show_types, :name, :name_nl
    add_column :show_types, :name_fr, :string
    add_column :show_types, :name_en, :string
  end

  def self.down
    rename_column :show_types, :name_nl, :name
    remove_column :show_types, :name_fr
    remove_column :show_types, :name_en
  end
end
