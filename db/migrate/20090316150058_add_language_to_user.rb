class AddLanguageToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :language_id, :integer
    remove_column :users, :language
  end

  def self.down
    add_column :users, :language, :string
    remove_column :users, :language_id
  end
end
