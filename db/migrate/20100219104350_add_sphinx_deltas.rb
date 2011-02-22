class AddSphinxDeltas < ActiveRecord::Migration
  def self.up
    add_column :archive_parts,        :delta, :boolean, :default => true, :null => false
    add_column :articles,             :delta, :boolean, :default => true, :null => false
    add_column :audio_video_titles,  :delta, :boolean, :default => true, :null => false
    add_column :book_titles,          :delta, :boolean, :default => true, :null => false
    add_column :ephemera,             :delta, :boolean, :default => true, :null => false
    add_column :ico_titles,           :delta, :boolean, :default => true, :null => false
    add_column :press_cuttings,       :delta, :boolean, :default => true, :null => false
  end

  def self.down
    remove_column :archive_parts,        :delta
    remove_column :articles,             :delta
    remove_column :audio__video_titles,  :delta
    remove_column :book_titles,          :delta
    remove_column :ephemera,             :delta
    remove_column :ico_titles,           :delta
    remove_column :press_cuttings,       :delta
  end
end