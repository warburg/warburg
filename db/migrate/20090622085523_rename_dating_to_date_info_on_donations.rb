class RenameDatingToDateInfoOnDonations < ActiveRecord::Migration
  def self.up
    rename_column :donations, :dating, :date_info
  end

  def self.down
    rename_column :donations, :date_info, :dating
  end
end
