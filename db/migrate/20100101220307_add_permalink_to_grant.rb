class AddPermalinkToGrant < ActiveRecord::Migration
  def self.up
    add_column :grants, :permalink, :string
  end

  def self.down
    remove_column :grants, :permalink
  end
end
