class RenameInspirationNumberOnProductions < ActiveRecord::Migration
  def self.up
    rename_column :productions, :inspiration_number, :inspiration
  end

  def self.down
    rename_column :productions, :inspiration, :inspiration_number
  end
end
