class RemoveDateFromGrants < ActiveRecord::Migration
  def self.up
    remove_column :grants, :date
  end

  def self.down
    add_column :grants, :date, :date
  end
end
