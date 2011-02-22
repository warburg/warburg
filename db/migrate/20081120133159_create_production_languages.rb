class CreateProductionLanguages < ActiveRecord::Migration
  def self.up
    create_table :production_languages do |t|
      t.integer :production_id
      t.integer :language_id
      t.string :note

      t.timestamps
      t.userstamps
    end
  end

  def self.down
    drop_table :production_languages
  end
end
