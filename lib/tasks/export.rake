require "fastercsv"

namespace :export do
  desc "Generate shows CSV file."
  task :shows => :environment do
    
    FasterCSV.open("#{RAILS_ROOT}/tmp/shows-dump.csv", 'w+', { :col_sep => ";", :headers => true }) do |csv|
      csv << [
        "id",
        "production_id",
        "country",
        "city",
        "location",
        "location website",
        "artist",
        "gezelschappen",
        "artist website",
        "type",
        "start datum"
      ]
      
      Show.find(:all,
                :joins      => :date,
                :conditions => ["date_isaars.year = 2011 AND (date_isaars.month = 1 OR date_isaars.month = 2)"]).each do |show|
        puts show.organisation.inspect
        csv << [
          show.id,
          show.production.try(:id),
          show.venue ? show.venue.country.try(:name_en) : nil,
          show.venue.try(:city),
          show.venue.try(:name),
          show.venue.try(:url),
          show.production.try(:title),
          show.production ? show.production.production_by_organisations.select { |prodorg| ["gezelschap", "producent"].include?(prodorg.function.try(:name_nl)) }.map(&:organisation).map(&:name).join(", ") : nil,
          show.organisation.try(:url),
          show.show_type.try(:name_nl),
          show.date
        ] 
      end
    end
  end
end