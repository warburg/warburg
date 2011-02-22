class AddClustersToProductionGenres < ActiveRecord::Migration
  def self.up
    add_column :production_genres, :cluster_danse, :boolean
    add_column :production_genres, :cluster_theatre, :boolean
    add_column :production_genres, :cluster_musictheatre, :boolean
    add_column :production_genres, :cluster_child_youth, :boolean
    add_column :production_genres, :cluster_other_disc, :boolean
    add_column :production_genres, :cluster_figure_object, :boolean
  end

  def self.down
    remove_column :production_genres, :cluster_danse    
    remove_column :production_genres, :cluster_theatre
    remove_column :production_genres, :cluster_musictheatre
    remove_column :production_genres, :cluster_child_youth     
    remove_column :production_genres, :cluster_other_disc
    remove_column :production_genres, :cluster_figure_object
  end
end
