class AddVersioningToDocuments < ActiveRecord::Migration
  def self.up
    ArchivePart.create_versioned_table
    add_column :archive_parts, :lock_version, :integer, :default => 0
    ArchivePart.update_all("lock_version = 0")
    
    Article.create_versioned_table
    add_column :articles, :lock_version, :integer, :default => 0
    Article.update_all("lock_version = 0")
    
    AudioVideoTitle.create_versioned_table
    add_column :audio_video_titles, :lock_version, :integer, :default => 0
    AudioVideoTitle.update_all("lock_version = 0")
    
    BookTitle.create_versioned_table
    add_column :book_titles, :lock_version, :integer, :default => 0
    BookTitle.update_all("lock_version = 0")
    
    Ephemerum.create_versioned_table
    add_column :ephemera, :lock_version, :integer, :default => 0
    Ephemerum.update_all("lock_version = 0")
    
    IcoTitle.create_versioned_table
    add_column :ico_titles, :lock_version, :integer, :default => 0
    IcoTitle.update_all("lock_version = 0")
    
    PressCutting.create_versioned_table
    add_column :press_cuttings, :lock_version, :integer, :default => 0
    PressCutting.update_all("lock_version = 0")
  end

  def self.down
    remove_column :archive_parts, :lock_version
    ArchivePart.drop_versioned_table
    
    remove_column :articles, :lock_version
    Article.drop_versioned_table
    
    remove_column :audio_video_titles, :lock_version
    AudioVideoTitle.drop_versioned_table
    
    remove_column :book_titles, :lock_version
    BookTitle.drop_versioned_table
    
    remove_column :ephemera, :lock_version
    Ephemerum.drop_versioned_table
    
    remove_column :ico_titles, :lock_version
    IcoTitle.drop_versioned_table
    
    remove_column :press_cuttings, :lock_version
    PressCutting.drop_versioned_table
  end
end
