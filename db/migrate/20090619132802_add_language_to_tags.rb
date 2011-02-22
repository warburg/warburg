class AddLanguageToTags < ActiveRecord::Migration
  def self.up
    add_column :tags, :language_id, :integer
  end

  def self.down
    remove_column :tags, :language_id
  end
end
