class RenameDescriptionToUrlInPeriodicals < ActiveRecord::Migration
  def self.up
    rename_column :periodicals, :description_nl, :url
  end

  def self.down
    rename_column :periodicals, :url, :description_nl
  end
end
