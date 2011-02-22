class DropSpuriousColumnsFromPeriodical < ActiveRecord::Migration
  def self.up
    remove_column :periodicals, :cardex
    remove_column :periodicals, :organisation_id
    remove_column :periodicals, :ranking
  end

  def self.down
    add_column :periodicals, :ranking, :integer
    add_column :periodicals, :organisation_id, :integer
    add_column :periodicals, :cardex, :string
  end
end
