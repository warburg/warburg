class RemoveEnFrDescriptionsFromPeriodicals < ActiveRecord::Migration
  def self.up
    remove_column :periodicals, :description_fr
    remove_column :periodicals, :description_en
  end

  def self.down
    add_column :periodicals, :description_fr, :string
    add_column :periodicals, :description_en, :string
  end
end
