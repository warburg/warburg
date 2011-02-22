class AddGistIndexes < ActiveRecord::Migration
  def self.up
    execute("CREATE INDEX trgm_people_last_name_idx ON people USING gist (last_name gist_trgm_ops)")
    execute("CREATE INDEX trgm_people_first_name_idx ON people USING gist (first_name gist_trgm_ops)")
    execute("CREATE INDEX trgm_archive_parts_title_idx ON archive_parts USING gist (title gist_trgm_ops)")
    execute("CREATE INDEX trgm_articles_title_idx ON articles USING gist (title gist_trgm_ops)")
    execute("CREATE INDEX trgm_audio_video_titles_title_idx ON audio_video_titles USING gist (title gist_trgm_ops)")
    execute("CREATE INDEX trgm_book_titles_title_idx ON book_titles USING gist (title gist_trgm_ops)")
    execute("CREATE INDEX trgm_ephemera_title_idx ON ephemera USING gist (title gist_trgm_ops)")
    execute("CREATE INDEX trgm_ico_titles_title_idx ON ico_titles USING gist (title gist_trgm_ops)")
    execute("CREATE INDEX trgm_organisations_name_idx ON organisations USING gist (name gist_trgm_ops)")
    execute("CREATE INDEX trgm_productions_title_idx ON productions USING gist (title gist_trgm_ops)")    
  end

  def self.down
    execute("DROP INDEX trgm_people_last_name_idx")
    execute("DROP INDEX trgm_people_first_name_idx")    
    execute("DROP INDEX trgm_archive_parts_title_idx")  
    execute("DROP INDEX trgm_articles_title_idx")
    execute("DROP INDEX trgm_audio_video_titles_title_idx")
    execute("DROP INDEX trgm_book_titles_title_idx")    
    execute("DROP INDEX trgm_ephemera_title_idx")
    execute("DROP INDEX trgm_ico_titles_title_idx")    
    execute("DROP INDEX trgm_organisations_name_idx")
    execute("DROP INDEX trgm_productions_title_idx")    
  end
end
