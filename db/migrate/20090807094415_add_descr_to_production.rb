class AddDescrToProduction < ActiveRecord::Migration
  def self.up
    add_column :productions, :description_nl, :text
    add_column :productions, :description_fr, :text
    add_column :productions, :description_en, :text
  end

  def self.down
    remove_column :productions, :description_en
    remove_column :productions, :description_fr
    remove_column :productions, :description_nl
  end
end
