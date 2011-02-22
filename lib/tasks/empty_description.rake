require 'csv'

namespace :db do
  namespace :empty do
    desc "empty description before jan 1 2010."
    task :description => :environment do
      puts "Generating letters for donations"
      
      # creates "2010-01-01 00:00:00"
      datetime = DateTime.civil(2010, 1, 1, 0, 0, 0, 0).to_s(:db)
      
      # select all before 1 jan 2010
      conditions = ["created_at < ?", datetime]
      date = AudioVideoTitle.all(:conditions => conditions)
      
      # Empty the description fields
      date.each do |desc|
        desc.description_en = nil
        desc.description_nl = nil
        desc.description_fr = nil
        desc.save
        puts "the field is empty "
      end
      
      # migrate the old-descriptons to the current descriptions
      
      
    end
  end
end