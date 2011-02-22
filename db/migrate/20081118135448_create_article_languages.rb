class CreateArticleLanguages < ActiveRecord::Migration
  def self.up
    create_table :article_languages do |t|
      t.integer :article_id
      t.integer :language_id

      t.timestamps
      t.userstamps
    end
  end

  def self.down
    drop_table :article_languages
  end
end
