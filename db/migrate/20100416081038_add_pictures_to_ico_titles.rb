class AddPicturesToIcoTitles < ActiveRecord::Migration
  def self.up
    add_column :ico_titles, :picture_file_name,    :string
    add_column :ico_titles, :picture_content_type, :string
    add_column :ico_titles, :picture_file_size,    :integer
    add_column :ico_titles, :picture_updated_at,   :datetime
    
    add_column :ico_title_versioned, :picture_file_name,    :string
    add_column :ico_title_versioned, :picture_content_type, :string
    add_column :ico_title_versioned, :picture_file_size,    :integer
    add_column :ico_title_versioned, :picture_updated_at,   :datetime
  end
  
  def self.down
    remove_column :ico_titles, :picture_file_name
    remove_column :ico_titles, :picture_content_type
    remove_column :ico_titles, :picture_file_size
    remove_column :ico_titles, :picture_updated_at
    
    remove_column :ico_title_versioned, :picture_file_name
    remove_column :ico_title_versioned, :picture_content_type
    remove_column :ico_title_versioned, :picture_file_size
    remove_column :ico_title_versioned, :picture_updated_at
  end
end
