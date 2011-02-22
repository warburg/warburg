module DeltaFlag
  
  def self.included(base)
    base.class_eval do
      after_save :set_delta_flags
    end
  end
    
  private
    
  def set_delta_flags
    if self.respond_to?(:audio_video_titles_by)
      AudioVideoTitle.update_all({:delta => true}, {:id => self.audio_video_titles_by_ids})
    end
    if self.respond_to?(:audio_video_titles_about)
      AudioVideoTitle.update_all({:delta => true}, {:id => self.audio_video_titles_about_ids})
    end
    if self.respond_to?(:archive_parts_by)
      ArchivePart.update_all({:delta => true}, {:id => self.archive_parts_by_ids})
    end
    if self.respond_to?(:archive_parts_about)
      ArchivePart.update_all({:delta => true}, {:id => self.archive_parts_about_ids})
    end
    if self.respond_to?(:press_cuttings_by)
      PressCutting.update_all({:delta => true}, {:id => self.press_cuttings_by_ids})
    end
    if self.respond_to?(:press_cuttings_about)
      PressCutting.update_all({:delta => true}, {:id => self.press_cuttings_about_ids})
    end
    if self.respond_to?(:articles_by)
      Article.update_all({:delta => true}, {:id => self.articles_by_ids})
    end
    if self.respond_to?(:articles_about)
      Article.update_all({:delta => true}, {:id => self.articles_about_ids})
    end
    if self.respond_to?(:book_titles_by)
      BookTitle.update_all({:delta => true}, {:id => self.book_titles_by_ids})
    end
    if self.respond_to?(:book_titles_about)
      BookTitle.update_all({:delta => true}, {:id => self.book_titles_about_ids})
    end
    if self.respond_to?(:ephemera_by)
      Ephemerum.update_all({:delta => true}, {:id => self.ephemera_by_ids})
    end
    if self.respond_to?(:ephemera_about)
      Ephemerum.update_all({:delta => true}, {:id => self.ephemera_about_ids})
    end
    if self.respond_to?(:ico_titles_by)
      IcoTitle.update_all({:delta => true}, {:id => self.ico_titles_by_ids})
    end
    if self.respond_to?(:ico_titles_about)
      IcoTitle.update_all({:delta => true}, {:id => self.ico_titles_about_ids})
    end
  end
end