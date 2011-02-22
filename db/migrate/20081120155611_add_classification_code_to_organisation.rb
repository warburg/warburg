class AddClassificationCodeToOrganisation < ActiveRecord::Migration
  def self.up
    add_column :organisations, :classification_code, :integer
    add_column :organisation_versions, :classification_code, :integer
  end

  def self.down
    remove_column :organisation_versions, :classification_code
    remove_column :organisations, :classification_code
  end
end
