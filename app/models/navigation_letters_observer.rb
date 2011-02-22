class NavigationLettersObserver < ActiveRecord::Observer
  observe :person, :organisation, :production, :archive_part, :article, :audio_video_title,
          :book_copy, :book_title, :ephemerum, :ico_title, :periodical, :press_cutting, :warehouse, :tag,
          :cdb_event, :cdb_organisation, :cdb_location, :user, :donation, :venue, :grant,
          :impressum, :festival

  def after_save(object)
    letters = NavigationLetters.find_or_create_by_classname(object.class.name)
    letters.letters ||= {}
    order_value = object.send(object.class.order_field)
    if order_value
      order_value = order_value.to_s.unaccent.capitalize
      letters.letters[order_value[/./]] ||= []
      unless letters.letters[order_value[/./]].include?(order_value[/../])
        if order_value[/../]
          letters.letters[order_value[/./]] << order_value[/../]
          letters.letters[order_value[/./]].sort!
          letters.save!
        end
      end
    end
  end

end
