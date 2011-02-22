namespace :friendly_id do
  desc "Make slugs for a model."
  task :make_slugs => :environment do
    FriendlyId::TaskRunner.new.make_slugs do |record|
      puts "%s(%d): friendly_id set to '%s'" % [record.class.to_s, record.id, record.slug.name] if record.slug
    end
  end

  desc "Regenereate slugs for a model."
  task :redo_slugs => :environment do
    FriendlyId::TaskRunner.new.delete_slugs
    Rake::Task["friendly_id:make_slugs"].invoke
  end

  desc "Destroy obsolete slugs older than DAYS=45 days."
  task :remove_old_slugs => :environment do
    FriendlyId::TaskRunner.new.delete_old_slugs
  end
  
  desc "Generate slugs for all the models that user friendly_id"
  task :generate => :environment do
    [:archive_part, :article, :audio_video_medium, :audio_video_title, :book_copy, :book_title, :cdb_event, :cdb_organisation, :country, :donation, :ephemerum, :gender, :genre,
     :grant_genre, :grant_system, :ico_title, :ico_type, :impressum, :language, :order, :organisation, :periodical, :periodical_issue, :person, :press_cutting, :production,
     :season, :show_type, :user, :venue, :warehouse, :tag].each do |model|
      system "rake friendly_id:make_slugs MODEL=#{model}"
    end
  end
  
  desc "Regenerate slugs for all the models that user friendly_id"
  task :regenerate => :environment do
    [:archive_part, :article, :audio_video_medium, :audio_video_title, :book_copy, :book_title, :cdb_event, :cdb_organisation, :country, :donation, :ephemerum, :gender, :genre,
     :grant_genre, :grant_system, :ico_title, :ico_type, :impressum, :language, :order, :organisation, :periodical, :periodical_issue, :person, :press_cutting, :production,
     :season, :show_type, :user, :venue, :warehouse, :tag].each do |model|
      puts "Regenerating slugs for #{model}"
      model.to_s.camelcase.constantize.all(:conditions => ['cached_slug like ?', '%--%']).each do |object|
        object.save
      end
    end
  end
  
  desc "Clean the peramlink permalink fields"
  task :clean_permalinks => :environment do
    [:archive_part, :article, :audio_video_medium, :audio_video_title, :book_copy, :book_title, :cdb_event, :cdb_organisation, :country, :donation, :ephemerum, :gender, :genre,
     :grant_genre, :grant_system, :ico_title, :ico_type, :impressum, :language, :order, :organisation, :periodical, :periodical_issue, :person, :press_cutting, :production,
     :season, :show_type, :user, :venue, :warehouse, :tag].each do |model|
      puts model
      model.to_s.classify.constantize.update_all("permalink = ''")
    end
  end
end