class ExtendArchivePartTitle < ActiveRecord::Migration
  def self.up
    change_column :archive_parts, :title, :string, :limit => 300
  end

  def self.down
    change_column :archive_parts, :title, :string, :limit => 255
  end
end
