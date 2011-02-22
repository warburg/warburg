class CreateProductionGenres < ActiveRecord::Migration
  def self.up
    create_table :production_genres do |t|
      t.string :name
      t.string :grouping_term
      t.integer :drupal_taxo_thirteen

      t.timestamps
      t.userstamps
    end
  end

  def self.down
    drop_table :production_genres
  end
end
