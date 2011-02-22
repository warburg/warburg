namespace :letters do
  namespace :generate do
    desc "Generate navigation letters for donations."
    task :donations => :environment do
      puts "Generating letters for donations"
      Donation.all.each { |obj| puts obj.id; obj.save! }
    end
    
    desc "Generate navigation letters for organisations."
    task :organisations => :environment do
      puts "Generating letters for organisations"
      nl = NavigationLetters.find_by_classname("Organisation")
      if nl.present?
        nl.destroy
      end
      Organisation.all.each { |obj| puts obj.id; obj.save! }
    end
    
    desc "Generate navigation letters for festivals."
    task :festivals => :environment do
      puts "Generating letters for festivals"
      Festival.all.each { |obj| puts obj.id; obj.save! }
    end
    
    desc "Generate navigation letters for venues."
    task :venues => :environment do
      puts "Generating letters for venues"
      Venue.all.each { |obj| puts obj.id; obj.save! }
    end
    
    desc "Generate navigation letters for grants."
    task :grants => :environment do
      puts "Generating letters for grants"
      Grant.all.each { |obj| puts obj.id; obj.save! }
    end
    
    desc "Generate navigation letters for impressums."
    task :impressums => :environment do
      puts "Generating letters for impressums"
      Impressum.all.each { |obj| puts obj.id; obj.save! }
    end
    
    desc "Generate all letters"
    task :all => [:donations, :festivals, :venues, :grants, :impressums]
  end
end