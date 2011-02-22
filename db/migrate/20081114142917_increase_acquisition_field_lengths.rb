class IncreaseAcquisitionFieldLengths < ActiveRecord::Migration
  def self.up
    change_column :acquisitions, :content, :string, :limit => 3000
    change_column :acquisitions, :note, :string, :limit => 3000
  end

  def self.down
    change_column :acquisitions, :note, :string, :limit => 255
    change_column :acquisitions, :content, :string, :limit => 255
  end
end
