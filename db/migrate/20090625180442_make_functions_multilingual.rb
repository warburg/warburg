class MakeFunctionsMultilingual < ActiveRecord::Migration
  def self.up
    rename_column :functions, :name, :name_nl
    add_column :functions, :name_fr, :string
    add_column :functions, :name_en, :string
  end

  def self.down
    remove_column :functions, :name_en
    remove_column :functions, :name_fr
    rename_column :functions, :name_nl, :name
  end
end
