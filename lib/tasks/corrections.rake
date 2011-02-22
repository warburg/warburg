namespace :db do
  namespace :correct do
    desc "Correct the barcodes."
    task :barcodes => :environment do
      puts "-> Correcting barcodes for book copies."
      BookCopy.find(:all, :conditions => ["barcode IS NULL OR barcode = ''"]).each { |book_copy| book_copy.update_attribute :barcode, book_copy.generate_barcode }
      
      puts "-> Correcting barcodes for periodical issues."
      PeriodicalIssue.find(:all, :conditions => ["barcode IS NULL OR barcode = ''"]).each { |periodical_issue| periodical_issue.update_attribute :barcode, periodical_issue.generate_barcode }
      
      puts "-> Correcting barcodes for audio video media."
      AudioVideoMedium.find(:all, :conditions => ["barcode IS NULL OR barcode = ''"]).each { |audio_video_medium| audio_video_medium.update_attribute :barcode, audio_video_medium.generate_barcode }
      
      puts "-> Correcting barcodes for warehouses."
      Warehouse.find(:all, :conditions => ["barcode IS NULL OR barcode = ''"]).each { |warehouse| warehouse.update_attribute :barcode, warehouse.generate_barcode }
    end
    
    desc "Correct unlinked taggings"
    task :taggings => :environment do
      puts "-> Correcting all zeroed out taggings."
      Tagging.destroy_all(["taggable_id = 0"])
      
      [BookTitle, Article, Person, AudioVideoTitle, Periodical, Donation, PressCutting, Production, Ephemerum, IcoTitle].each do |klass|
        puts "-> Correcting #{klass.table_name}"
        ids = klass.all(:select => :id).map(&:id).join(",")
        Tagging.destroy_all(["taggable_type = '#{klass.to_s}' AND taggable_id NOT IN (" + ids + ")"])
      end
    end
    
    desc "Correct production languages"
    task :production_languages => :environment do
      puts "-> Correcting all the duplicate production languages"
      production_id = nil
      language_id   = nil
      ProductionLanguage.find_by_sql("SELECT * FROM production_languages WHERE production_id IN (SELECT production_id FROM production_languages GROUP BY language_id, production_id HAVING count(id) > 1) AND language_id IN (SELECT language_id FROM production_languages GROUP BY language_id, production_id HAVING count(id) > 1) ORDER BY production_id, language_id").each do |prod_lang|
        if production_id == prod_lang.production_id && language_id == prod_lang.language_id
          production_id = prod_lang.production_id
          language_id   = prod_lang.language_id
          prod_lang.destroy
        else
          production_id = prod_lang.production_id
          language_id   = prod_lang.language_id
        end        
      end
    end
    
    desc "Correct organisations"
    task :organisations => :environment do
      puts "-> Saving all organisation instances"
      Organisation.all(:conditions => ["sorted_name IS NULL OR sorted_name = ''"]).each do |organisation|
        organisation.save
      end
    end
  end
end