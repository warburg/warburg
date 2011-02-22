class AddMultilingualToPeriodicals < ActiveRecord::Migration
  def self.up
    rename_column :periodicals, :description, :description_nl
    add_column :periodicals, :description_fr, :string
    add_column :periodicals, :description_en, :string
  end

  def self.down
    rename_column :periodicals, :description_nl, :description
    remove_column :periodicals, :description_fr
    remove_column :periodicals, :description_en
  end
end
