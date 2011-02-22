class AddLanguageRoles < ActiveRecord::Migration
  def self.up
    add_column :article_languages, :language_role_id, :integer
    add_column :book_title_languages, :language_role_id, :integer
    add_column :production_languages, :language_role_id, :integer
    add_column :periodical_languages, :language_role_id, :integer
    add_column :press_cutting_languages, :language_role_id, :integer
    remove_column :periodical_languages, :language_note
  end

  def self.down
    add_column :periodical_languages, :language_note, :string
    remove_column :press_cutting_languages, :language_role_id
    remove_column :periodical_languages, :language_role_id
    remove_column :production_languages, :language_role_id
    remove_column :book_title_languages, :language_role_id
    remove_column :article_languages, :language_role_id
  end
end
