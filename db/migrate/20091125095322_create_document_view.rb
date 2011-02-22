class CreateDocumentView < ActiveRecord::Migration
  def self.up
    # ArchivePart Article AudioVideoTitle BookTitle Ephemerum IcoTitle PressCutting
    
    add_column :archive_parts, :class_name, :string, :default => 'ArchivePart'
    add_column :articles, :class_name, :string, :default => 'Article'
    add_column :audio_video_titles, :class_name, :string, :default => 'AudioVideoTitle'
    add_column :book_titles, :class_name, :string, :default => 'BookTitle'
    add_column :ephemera, :class_name, :string, :default => 'Ephemerum'
    add_column :ico_titles, :class_name, :string, :default => 'IcoTitle'
    add_column :press_cuttings, :class_name, :string, :default => 'PressCutting'
    

    sql_statement =<<-HEREEND
    UPDATE archive_parts SET class_name = 'ArchivePart';
    UPDATE articles SET class_name = 'Article';
    UPDATE audio_video_titles SET class_name = 'AudioVideoTitle';
    UPDATE book_titles SET class_name = 'BookTitle';
    UPDATE ephemera SET class_name = 'Ephemerum';
    UPDATE ico_titles SET class_name = 'IcoTitle';
    UPDATE press_cuttings SET class_name = 'PressCutting';
    HEREEND

    execute(sql_statement)
        
    sql_statement =<<-HEREEND
    CREATE OR REPLACE VIEW documents AS
      SELECT archive_parts.id, archive_parts.title, archive_parts.created_at, 
             archive_parts.updated_at, archive_parts.views, archive_parts.viewed_at,
             archive_parts.permalink, archive_parts.class_name
             FROM archive_parts
      UNION ALL
      SELECT articles.id, articles.title, articles.created_at, 
             articles.updated_at, articles.views, articles.viewed_at,
             articles.permalink, articles.class_name
             FROM articles
      UNION ALL
      SELECT audio_video_titles.id, audio_video_titles.title, audio_video_titles.created_at, 
             audio_video_titles.updated_at, audio_video_titles.views, audio_video_titles.viewed_at,
             audio_video_titles.permalink, audio_video_titles.class_name
             FROM audio_video_titles
      UNION ALL
      SELECT book_titles.id, book_titles.title, book_titles.created_at, 
             book_titles.updated_at, book_titles.views, book_titles.viewed_at,
             book_titles.permalink, book_titles.class_name
             FROM book_titles
      UNION ALL
      SELECT ephemera.id, ephemera.title, ephemera.created_at, 
             ephemera.updated_at, ephemera.views, ephemera.viewed_at,
             ephemera.permalink, ephemera.class_name
             FROM ephemera
      UNION ALL
      SELECT ico_titles.id, ico_titles.title, ico_titles.created_at, 
            ico_titles.updated_at, ico_titles.views, ico_titles.viewed_at,
            ico_titles.permalink, ico_titles.class_name
            FROM ico_titles
      UNION ALL
      SELECT press_cuttings.id, press_cuttings.title, press_cuttings.created_at, 
            press_cuttings.updated_at, press_cuttings.views, press_cuttings.viewed_at,
            press_cuttings.permalink, press_cuttings.class_name
            FROM press_cuttings
     ;

    HEREEND

    execute(sql_statement)
  end

  def self.down
    execute('DROP VIEW documents;')
    remove_column :archive_parts, :class_name
    remove_column :articles, :class_name
    remove_column :audio_video_titles, :class_name
    remove_column :book_titles, :class_name
    remove_column :ephemera, :class_name
    remove_column :ico_titles, :class_name
    remove_column :press_cuttings, :class_name
    
  end
end
