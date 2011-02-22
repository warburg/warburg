class AddLanguageRoleIdToRelationships < ActiveRecord::Migration
  def self.up
    add_column :relationships, :language_role_id, :integer
  end

  def self.down
    remove_column :relationships, :language_role_id
  end
end
