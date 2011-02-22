class RemoveTaxoThirteen < ActiveRecord::Migration
  def self.up
    remove_column :production_genres, :drupal_taxo_thirteen
  end

  def self.down
    add_column :production_genres, :drupal_taxo_thirteen, :integer
  end
end
