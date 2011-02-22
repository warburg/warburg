class AddIndexOnClassNames < ActiveRecord::Migration
  def self.up
    add_index :archive_parts, :class_name
    add_index :articles, :class_name
    add_index :audio_video_titles, :class_name
    add_index :book_titles, :class_name
    add_index :ephemera, :class_name
    add_index :ico_titles, :class_name
    add_index :press_cuttings, :class_name    
  end

  def self.down
    remove_index :archive_parts, :class_name
    remove_index :articles, :class_name
    remove_index :audio_video_titles, :class_name
    remove_index :book_titles, :class_name
    remove_index :ephemera, :class_name
    remove_index :ico_titles, :class_name
    remove_index :press_cuttings, :class_name    
  end
end
