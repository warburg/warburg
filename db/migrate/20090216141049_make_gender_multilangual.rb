class MakeGenderMultilangual < ActiveRecord::Migration
  def self.up
    add_column :genders, :name_nl, :string
    add_column :genders, :name_fr, :string
    add_column :genders, :name_en, :string
  end

  def self.down
    remove_column :genders, :name_nl
    remove_column :genders, :name_fr
    remove_column :genders, :name_en
  end
end
