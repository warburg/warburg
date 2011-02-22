class CreateMissingTranslations < ActiveRecord::Migration
  def self.up
    create_table :missing_translations do |t|
      t.string :key

      t.timestamps
    end
  end

  def self.down
    drop_table :missing_translations
  end
end
