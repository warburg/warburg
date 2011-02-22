# One-off script to load translations into ProductionGenres.

Old::ProductieGenre.find_each do |opg|
	v = Old::VertaalTabel.first(:conditions => ['Context = ? and NL = ?', 'production_genres', opg.ProductiesGenre])
	pg = ProductionGenre.find_by_name_nl(Iconv.conv('UTF8', 'ISO_8859-15', opg.ProductiesGenre))
	pg.name_fr = Iconv.conv('UTF8', 'ISO_8859-15', v.FR)
	pg.name_en = Iconv.conv('UTF8', 'ISO_8859-15', v.EN)
	puts pg.name_fr
	pg.save!
end


# To load the search_alternatives:
# 
# Old::ProductieGenre.find_each do |opg|
#   pg = Genre.find_by_old_id(opg.id)
#   pg.search_alternatives = Iconv.conv('UTF8', 'ISO_8859-15', opg.SearchAlternatives)
#   puts pg.inspect
#   pg.save!
# end


# Generate the lines for the relations:
# 
# [ArchivePart, Article, AudioVideoTitle, BookTitle, Ephemerum, IcoTitle, PressCutting, Person, Organisation].each{|cl|
#   puts "has_many :about_genres, :through => :#{cl.name.underscore}_about_genres, :source => :genre"
#     puts "has_many :#{cl.name.underscore}_about_genres"
# }

# Load the trefwoorden into the genres:
do_load_tagging('DocuOverTrefwoorden', 'DocuId', Ephemerum)
do_load_tagging('IcoOverTrefwoorden', 'IcoTitelId', IcoTitle)
do_load_tagging('TrefwoordenBijTijdschrift', 'TijdschriftId', Periodical)
do_load_tagging('VerwervingOverTrefwoorden', 'VerwervingId', Donation)

# Old::MasterPersoon.connection.select_all("select * from Trefwoorden t, BoekTitelOverTrefwoord r where t.ProductieGenreID is not null and r.TrefwoordId = t.TrefwoordId and r.BoekTitelId is not null")


# BoekTitelOverTrefwoord
# 
# count = 0
# start = Time.now
# Old::MasterPersoon.connection.select_all("select * from Trefwoorden t, BoekTitelOverTrefwoord r where t.ProductieGenreID is not null and r.TrefwoordId = t.TrefwoordId and r.BoekTitelId is not null").each do |row|
#   genre = Genre.find_by_old_id row['ProductieGenreID']
#   b = BookTitle.find_by_old_id(row['BoekTitelId'])
#   if b && genre
#     BookTitleAboutGenre.create(:book_title_id => b.id, :genre_id => genre.id)
#   else
#     puts "No BookTitle or Genre found for #{row.inspect}"
#   end
#   count += 1
#   if count % 1000 == 0
#        puts "Handled #{count} relations in #{Time.now - start} s   (#{(Time.now-start)/count} rows/s)"
#   end
# end
# puts "Finished! Handled #{count} relations in #{Time.now - start} s   (#{(Time.now-start)/count} rows/s)"


# AVOverTrefwoorden
# 
# count = 0
# start = Time.now
# Old::MasterPersoon.connection.select_all("select * from Trefwoorden t, AVOverTrefwoorden r where t.ProductieGenreID is not null and r.TrefwoordId = t.TrefwoordId and r.AVTitelId is not null").each do |row|
#   genre = Genre.find_by_old_id row['ProductieGenreID']
#   av = AudioVideoTitle.find_by_old_id(row['AVTitelId'])
#   if av && genre
#     AudioVideoTitleAboutGenre.create(:audio_video_title_id => av.id, :genre_id => genre.id)
#   else
#     puts "No AudioVideoTitle or Genre found for #{row.inspect}"
#   end
#   count += 1
#   if count % 1000 == 0
#        puts "Handled #{count} relations in #{Time.now - start} s   (#{(Time.now-start)/count} rows/s)"
#   end
# end
# puts "Finished! Handled #{count} relations in #{Time.now - start} s   (#{(Time.now-start)/count} rows/s)"


# Old::MasterPersoon.connection.select_all("select count(*) from Trefwoorden where ProductieGenreID is not null")
# 
# Old::MasterPersoon.connection.select_all("select top 10 * from ArtikelsOverTrefwoord where ArtikelId = 151716")

# Old::Artikel.find_by_ArtikelId 151716

# Old::MasterPersoon.connection.select_all("select * from Trefwoorden t, AVOverTrefwoorden r where t.ProductieGenreID is not null and r.TrefwoordId = t.TrefwoordId and r.AVTitelId is not null")


# ArtikelsOverTrefwoord
# 
# count = 0
# start = Time.now
# Old::MasterPersoon.connection.select_all("select t.Trefwoord, t.ProductieGenreId, r.ArtikelId from Trefwoorden t, ArtikelsOverTrefwoord r where t.ProductieGenreID is not null and r.TrefwoordId = t.TrefwoordId and r.ArtikelId is not null").each do |row|
#   genre = Genre.find_by_old_id row['ProductieGenreId']
#   artikel = PressCutting.find_by_old_id(row['ArtikelId']) || Article.find_by_old_id(row['ArtikelId'])
#   if artikel
#         if artikel.is_a? Article
#             ArticleAboutGenre.create(:article_id => artikel.id, :genre_id => genre.id)
#         else
#             PressCuttingAboutGenre.create(:press_cutting_id => artikel.id, :genre_id => genre.id)
#         end
#     else
#         puts "No article or presscutting found for #{row.inspect}"
#     end
#     count += 1
#     if count % 1000 == 0
#          puts "Handled #{count} relations in #{Time.now - start} s   (#{(Time.now-start)/count} rows/s)"
#     end
# end
# puts "Finished! Handled #{count} relations in #{Time.now - start} s   (#{(Time.now-start)/count} rows/s)"

