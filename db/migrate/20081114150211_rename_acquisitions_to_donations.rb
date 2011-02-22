class RenameAcquisitionsToDonations < ActiveRecord::Migration
  def self.up
    rename_table :acquisitions, :donations
    rename_column :donations, :acquisition_date, :donation_date
  end

  def self.down
    rename_column :donations, :donation_date, :acquisition_date
    rename_table :donations, :acquisitions
  end
end
