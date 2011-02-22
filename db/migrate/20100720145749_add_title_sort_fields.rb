class AddTitleSortFields < ActiveRecord::Migration
  def self.up
    add_column :organisations,         :sorted_name, :string
    add_column :organisation_versions, :sorted_name, :string
  end

  def self.down
    remove_column :organisations,         :sorted_name
    remove_column :organisation_versions, :sorted_name
  end
end
