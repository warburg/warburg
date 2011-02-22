class ExtendTitleForEphemera < ActiveRecord::Migration
  def self.up
    change_column :ephemera, :title, :string, :limit => 300
  end

  def self.down
    change_column :ephemera, :title, :string, :limit => 255
  end
end
