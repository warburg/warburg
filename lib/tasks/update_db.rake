namespace :db do
  namespace :update do
    desc "update options for organisation_from and organisation_to into organisation_relation_tyes. 
          Rake task also updates AV-titles"
    task :update_db => :environment do
      
      ### update one field in organisation_relation_type
      # OrganisationRelationType.update(126, :to_name_nl => 'Gefusioneerd in')
      # puts "the field to_name_nl in Organisation_relation_type changed to Gefusioneerd in"
      # 
      # # begin select all AV-Titles where updater_id = 0
      # foo = AudioVideoTitle.find(:all, :conditions => {:updater_id => ["0"]})
      # foo.each do |u|
      #   if u.creator_id > 0
      #     u.updater_id = u.creator_id
      #     u.save
      #     puts "the field where updater = 0 and creator > 0 are updated"
      # 
      #   else
      #     u.updater_id = 3405
      #     u.save
      #     puts "the field where creator = 0 is updated"
      #   end
      # end
      ### end 
      
      ### update the records where the rerun_of_id could not been found in the prodiction.id
      # connection = ActiveRecord::Base.connection();
      # connection.execute("update productions set rerun_of_id = null where rerun_of_id is not null and rerun_of_id not in (select id from productions)")
      #   puts "update the records where the rerun_of_id could not been found in the prodiction.id"
      # 
      # connection.execute("delete from postits where user_id = 4")
      #   puts "delete the records where user_id from postits = 4 and postitable had double records"
      # 
      # connection.execute("update shows set venue_id = null where venue_id not in (select id from venues);")
      #   puts "update the records where venue_id from shows not exist in venues_id"
      # 
      #   # mass excecute db for update_id or creator_id = 0
      #     puts "-----------------------------------------------"
      #     puts " BEGIN all update_id and creator_id are updated"
      #     puts "-----------------------------------------------"
      # 
      #   connection.execute("update venues set updater_id = 3405 where updater_id = 0")
      #     puts "venues are updated"
      # 
      #   connection.execute("update venues set creator_id = 3405 where creator_id = 0")
      #     puts "venues are updated"
      # 
      #   connection.execute("update shows set updater_id = 3405 where updater_id = 0")
      #     puts "shows are updated"
      # 
      #   connection.execute("update book_copies set updater_id = 3405 where updater_id = 0")
      #     puts "book_copies are updated"
      # 
      #   connection.execute("update articles set updater_id = 3405 where updater_id = 0")
      #     puts "articles are updated"
      # 
      #   connection.execute("update ico_titles set updater_id = 3405 where updater_id = 0")
      #     puts "ico_titles are updated"
      #     
      #   connection.execute("update book_titles set updater_id = 3405 where updater_id = 0")
      #     puts "book_titles are updated"
      # 
      #     puts "---------------------------------------------"
      #     puts " END all update_id and creator_id are updated"
      #     puts "---------------------------------------------"
      #   # end mass excecute
      ### end

      connection = ActiveRecord::Base.connection();
      connection.execute("update relationships set visible = 'f' where visible = 't' and production_id in (select id from productions where visible = 'f');")
        puts "update the records where the production.visible field is not in common with relationships.visible"
      end
  end
end