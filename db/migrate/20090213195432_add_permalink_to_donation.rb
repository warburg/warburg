class AddPermalinkToDonation < ActiveRecord::Migration
  def self.up
    add_column :donations, :permalink, :string
  end

  def self.down
    remove_column :donations, :permalink
  end
end
