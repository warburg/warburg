#!/usr/bin/env ruby
# encoding: utf-8

MIGRATION_ENV = ARGV[0]
RAILS_ENV = MIGRATION_ENV || 'migration_test'

require File.dirname(__FILE__) + '/../config/boot'
require File.dirname(__FILE__) + '/../config/environment'


class Migrator
  NOT_FOUND = 'NOT FOUND'

  def initialize
    error_logfile = File.open(File.dirname(__FILE__)+'/../log/error.log', 'a')
    error_logfile.sync = true
    @error_logger = Logger.new(error_logfile)
    progress_logfile = File.open(File.dirname(__FILE__)+'/../log/progress.log', 'a')
    progress_logfile.sync = true
    @progress_logger = Logger.new(progress_logfile)
  end
  
  def run
    stars = "*******************"
    msg = "START NEW SESSION"
    line = stars + "*" + msg.gsub(/./, '*') + "*" + stars

    3.times { log_error line }
    log_error stars + ' ' + msg + ' ' + stars
    3.times { log_error line }


    log_progress "Migrating DB in environment #{RAILS_ENV}"
    
    start = Time.now
    log_progress "Started at #{start}"
    
    # log_progress sizes_information(Old::Documentatie).inspect
    # exit

    @cache ||= Hash.new
    
    to_load = [
              User,
              Language,
              LanguageRole,
              Gender,
              Country,
              Person,
              LegalForm,
              Organisation,
              Donation,
              Periodical,
              Impressum,
              PeriodicalImpressum,
              BoxType,
              Warehouse,
              PeriodicalIssue,
              PeriodicalLanguage,
              Article,
              PressCutting,
              AudioVideoMediumType,
              ArticleLanguage,
              PressCuttingLanguage,
              AudioVideoMedium,
              AudioVideoTitle,
              AudioVideoLanguage,
              LanguageRole,
              ArchivePart,
              BookTitle,
              BookCopy,
              BookTitleImpressum,
              BookTitleLanguage,
              EphemerumType,
              Ephemerum,
              EphemerumLanguage,
              Production,
              ProductionLanguage,
              GrantGenre,
              GrantSystem,
              GrantState,
              Grant,
              Festival,
              AudioVideoTitleOnMedium,
              Alumnus,
              Function,
              IcoType,
              IcoTitle,
              Venue,
              ShowType,
              Show,
              ProductionGenre,
              OrganisationRelationType,
              OrganisationRelation,
              DateIsaar,      # don't delete!
              Order,
              Relationship,
              Postit,         # don't delete!
              Season,         # don't delete!
              Tagging,
              NavigationLetters, # don't delete!
              Tag
              ]
    
    to_load.reverse.each {|cl| delete cl}
    
    to_load.each {|cl| load cl}

    make_seasons_visible

    log_progress "\nFinished in #{Time.now - start} s, at #{Time.now}"
  rescue StandardError => bang
    log_progress "\nCrashed after #{Time.now - start} s, at #{Time.now}"
    log_error(bang)
    raise bang
  end

  def make_seasons_visible
    log_progress "Making Seasons visible"
    Season.all.each do |season|
      season.visible = !Old::DrupalSeizoenToExport.find_by_seizoen(season.name).nil?
      season.save! if season.visible
      log_progress "Set Season #{season.name} to #{season.visible ? '' : 'in'}visible"
    end
    log_progress "Seasons made visible"
  end

  ### Load methods

  def load_navigation_letters
  end
  
  def load_tag
  end
  
  def load_season
  end

  def load_tagging
    do_load_tagging('ArtikelsOverTrefwoord', 'ArtikelId', Article)
    do_load_tagging('AVOverTrefwoorden', 'AVTitelId', AudioVideoTitle)
    do_load_tagging('BoekTitelOverTrefwoord', 'BoekTitelId', BookTitle)
    do_load_tagging('DocuOverTrefwoorden', 'DocuId', Ephemerum)
    do_load_tagging('IcoOverTrefwoorden', 'IcoTitelId', IcoTitle)
    do_load_tagging('TrefwoordenBijTijdschrift', 'TijdschriftId', Periodical)
    do_load_tagging('VerwervingOverTrefwoorden', 'VerwervingId', Donation)
  end

  def do_load_tagging(old_table_name, old_taggable_id_name, new_clazz)
    start = Time.now
    sql = "select c.#{old_taggable_id_name} as old_id, t.Trefwoord as tag_name from #{old_table_name} c, Trefwoorden t where c.TrefwoordId = t.TrefwoordId"
    conn = Old::MasterPersoon.connection
    total = conn.select_value("select count(*) from #{old_table_name}")
    log_progress "Going to load #{total} taggings from #{old_table_name}"
    i = 0
    ActiveRecord::Base.transaction do
      conn.select_all(sql).each do |row|
        taggable_id = fetch_id(new_clazz, row['old_id'])
        if new_clazz.name == 'Article' && taggable_id.nil?
          new_clazz = PressCutting
          taggable_id = fetch_id(PressCutting, row['old_id'])
        end
        if taggable_id
          Tagging.create(
            :taggable_id => taggable_id,
            :taggable_type => new_clazz.to_s,
            :tag_id => fetch_id(Tag, row['tag_name'])
          )
          i += 1
          if i % 1000 == 0
            log_progress "  Loaded #{i} taggings from #{old_table_name}"
          end
        end
      end
    end
    log_progress "Now a total of #{Tagging.count} taggings after migration of #{old_table_name}, which took #{Time.now - start} s"
  end
  
  def load_relationship
    load_with_sql(ArchivePartAboutOrganisation, 'ArchiefBestanddelenOverOrganisaties')
    load_with_sql(ArchivePartAboutPerson, 'ArchiefBestanddelenOverPersonen')
    load_with_sql(ArchivePartAboutProduction, 'ArchiefBestanddelenOverProducties')
    load_with_sql(ArticleByOrganisation, :ArtikelsDoorOrganisaties, {:function => :FunctieId})
    load_with_sql(ArticleByPerson, :ArtikelsDoorPersonen, :function => :FunctieId)
    load_with_sql(ArticleAboutOrganisation, :ArtikelsOverOrganisaties)
    load_with_sql(ArticleAboutPerson, :ArtikelsOverPersonen)
    load_with_sql(ArticleAboutProduction, :ArtikelsOverProducties)
    load_with_sql(AudioVideoTitleByOrganisation, :AVDoorOrganisaties, {:function_text => :FunctieColofon, :function => :FunctieId})
    load_with_sql(AudioVideoTitleByPerson, :AVDoorPersonen, {:function_text => :FunctieColofon, :function => :FunctieId})
    load_with_sql(AudioVideoTitleAboutOrganisation, :AVOverOrganisaties)
    load_with_sql(AudioVideoTitleAboutPerson, :AVOverPersonen)
    load_with_sql(AudioVideoTitleAboutProduction, :AVOverProducties)
    load_with_sql(BookTitleByOrganisation, :BoekTitelDoorOrganisaties, {:function_text => :OrganisatieFunctie})
    load_with_sql(BookTitleByPerson, :BoekTitelDoorPersonen, {:function => :FunctieId, :function_text => :FunctieColofon, :person => :PersonenId})
    load_with_sql(BookTitleAboutOrganisation, :BoekTitelOverOrganisaties)
    load_with_sql(BookTitleAboutPerson, :BoekTitelOverPersonen)
    load_with_sql(BookTitleAboutProduction, :BoekTitelOverProducties)
    load_with_sql(EphemerumByOrganisation, :DocuDoorOrganisaties, {:function => :FunctieId})
    load_with_sql(EphemerumByPerson, :DocuDoorPersonen, {:function => :FunctieId})
    load_with_sql(EphemerumAboutOrganisation, :DocuOverOrganisaties)
    load_with_sql(EphemerumAboutPerson, :DocuOverPersonen)
    load_with_sql(EphemerumAboutProduction, :DocuOverProducties)
    load_with_sql(IcoTitleByOrganisation, :IcoDoorOrganisaties, {:function_text => :FunctieColofon, :function => :FunctieId})
    load_with_sql(IcoTitleByPerson, :IcoDoorPersonen, {:function_text => :FunctieColofon, :function => :FunctieId})
    load_with_sql(IcoTitleAboutOrganisation, :IcoOverOrganisaties)
    load_with_sql(IcoTitleAboutPerson, :IcoOverPersonen)
    load_with_sql(IcoTitleAboutProduction, :IcoOverProducties)
    load_with_sql(PressCuttingByOrganisation, :ArtikelsDoorOrganisaties, {:function => :FunctieId})
    load_with_sql(PressCuttingByPerson, :ArtikelsDoorPersonen, :function => :FunctieId)
    load_with_sql(PressCuttingAboutOrganisation, :ArtikelsOverOrganisaties)
    load_with_sql(PressCuttingAboutPerson, :ArtikelsOverPersonen)
    load_with_sql(PressCuttingAboutProduction, :ArtikelsOverProducties)
    load_with_sql(ProductionByOrganisation, :ProductiesDoorOrganisaties, {:function_text => :OrganisatieFunctie, :function => :OrganisatieFunctieId})
    load_with_sql(ProductionByPerson, :ProductiesDoorPersonen, {:function_text => :FunctieTekst, :function => :FunctieId, :role_info => :RolInfo})
    load_with_sql(OrganisationVenue, :OrganisatiesBijRuimtes)
    
    ArticleAboutOrganisation.delete_all('article_id is null')
    ArticleAboutOrganisation.delete_all('organisation_id is null')
    ArticleAboutPerson.delete_all('article_id is null')
    ArticleAboutPerson.delete_all('person_id is null')
    PressCuttingAboutOrganisation.delete_all('press_cutting_id is null')
    PressCuttingAboutOrganisation.delete_all('organisation_id is null')
    PressCuttingAboutOrganisation.delete_all('organisation_id is null')
    PressCuttingAboutPerson.delete_all('person_id is null')
    PressCuttingAboutPerson.delete_all('press_cutting_id is null')

    ArticleByOrganisation.delete_all('article_id is null')
    ArticleByOrganisation.delete_all('organisation_id is null')
    ArticleByPerson.delete_all('article_id is null')
    ArticleByPerson.delete_all('person_id is null')
    PressCuttingByOrganisation.delete_all('press_cutting_id is null')
    PressCuttingByOrganisation.delete_all('organisation_id is null')
    PressCuttingByOrganisation.delete_all('organisation_id is null')
    PressCuttingByPerson.delete_all('person_id is null')
    PressCuttingByPerson.delete_all('press_cutting_id is null')
    
  end

  def load_language_role
  end
  
  def load_with_sql(clazz, old_table_name, mapping = {})
    # log_progress("invoking load_with_sql(#{clazz}, #{old_table_name}, #{mapping.inspect})")
    final_mapping = {
      :archive_part => :ArchiefBestanddeelid,
      (clazz.name =~ /PressCutting.*/ ? :press_cutting : :article) => :ArtikelId,
      :audio_video_title => :AVTitelId,
      :book_title => :BoekTitelId,
      :ephemerum => :DocuId,
      :function_text => :FunctieTekst,
      :ico_title => :IcoTitelId,
      :index => :Volgnummer,
      :language => :IsoTaalcode,
      :language_note => :Taalnota,
      :organisation => :OrganisatieId,
      :person => :PersoonId,
      :production => :ProductieId,
      :production_genre => :ProductiesGenreId,
      :reference_type => :SoortVerwijzing,
      :venue => :RuimteId
    }
    if (clazz.name == 'ArticleLanguage')
      final_mapping = mapping
    else
      final_mapping.merge!(mapping)
    end
    
    old_table_name = old_table_name.to_s
    
    conn = Old::MasterPersoon.connection
    orig_count = conn.select_value("select count(*) from #{old_table_name}")
    log_progress "Going to load #{orig_count} rows from #{old_table_name}"
    start = Time.now
    sql = "select * from #{old_table_name}"
    counter = 0
    ActiveRecord::Base.transaction do
      conn.select_all(sql).each do |row|
        r =  clazz.new
        final_mapping.each do |key, value|
          reflection = clazz.reflect_on_association(key)
          if reflection.nil?
            r.send("#{key.to_s}=", row[value.to_s]) unless row[value.to_s].nil?
          else
            unless row[value.to_s].nil?
              target_id = fetch_id(reflection.klass, row[value.to_s])
              if NOT_FOUND == target_id
                if reflection.klass.name == 'Article'
                  # Do nothing: maybe it's a PressCutting
                elsif reflection.klass.name == 'PressCutting'
                  if fetch_id(Article, row[value.to_s]) == NOT_FOUND
                    msg = "Not found: #{old_table_name} has attribute #{value.to_s} = #{row[value.to_s]}, but a #{reflection.klass} nor an Article with that old_id doesn't exist."
                    log_error msg
                    next
                  end
                else
                  msg = "Not found: #{old_table_name} has attribute #{value.to_s} = #{row[value.to_s]}, but a #{reflection.klass} with that old_id doesn't exist."
                  log_error msg
                  next
                end
              else
                r.send("#{key.to_s}_id=", target_id)
              end
            end
          end
        end
        stamp_with_sql(r, row)
        unless r.save(false)
          log_error("Could not save relationship #{r.inspect} (#{r.errors.inspect})")
        end
        counter += 1
        if counter % 1000 == 0
          log_progress " Loaded #{counter} of #{orig_count} in #{Time.now - start} s (Average speed: #{(Time.now - start) / counter} s per record)"
        end
      end
    end
    log_progress "Saved #{clazz.count} objects of class #{clazz} in #{Time.now - start} s"
  end
  
  def stamp_with_sql(record, row)
    if row.has_key?('InvoerDatum')
      record.created_at = row['InvoerDatum']
    else
      record.created_at = row['Invoerdatum']
    end
    if row.has_key?('WijzigDatum')
      record.updated_at = row['WijzigDatum']
    else
      record.updated_at = row['Wijzigdatum']
    end

    record.creator_id = fetch_id(User, row['InvoerUser'])
    record.updater_id = fetch_id(User, row['WijzigUser'])
#  rescue StandardError => bang
#    log_progress "#{bang} with stamp_with_sql for #{row.inspect}"
  end

  def load_postit
  end
  
  def load_order
    do_load(Order, Old::Bestelling,
    {
      :organisation => [Organisation, :OrganisatieId],
      :date => :BestelDatum,
      :type => :Bestelwijze,
      :sent => :Verzonden,
      :order_number => :NotaBestelnummer
    })
  end
  
  def load_organisation_relation
    do_load(OrganisationRelation, Old::OrganisatieRelatie,
    {
      :from => [Organisation, :VanOrganisatieId],
      :to => [Organisation, :NaarOrganisatieId],
      :organisation_relation_type => [OrganisationRelationType, :RelatieId]
    })
  end
  
  def load_organisation_relation_type
    do_load(OrganisationRelationType, Old::Relatie,
    {
      :from_name => [:RelatieVan, "organisation_relation_fro"],
      :to_name => [:RelatieNaar, "organisation_relation_to"]
    })
  end
  
  def load_production_genre
    do_load(ProductionGenre, Old::ProductieGenre, 
    {    :name => :ProductiesGenre,
         :grouping_term => :Groeperingsterm,
         :cluster_danse => :ClusterDans, 
         :cluster_theatre       => :ClusterTheater,
         :cluster_musictheatre  => :ClusterMuziektheater, 
         :cluster_child_youth   => :ClusterKinderJeugd,
         :cluster_other_disc    => :ClusterAndereDisc,
         :cluster_figure_object => :ClusterFiguurObject
    })
  end
    
  def load_show
    clazz = Old::ProductieVoorstelling
    #premiere_column = clazz.column_names.find{|name| name =~ /Prem.*/}
    
    do_load(Show, Old::ProductieVoorstelling, 
    {
       :production => [Production, :ProductieId],
       :show_type => [ShowType, :VoorstellingenSoortId],
       :venue => [Venue, :RuimteId],
       :organisation => [Organisation, :OrganisatieId],
       :date => :Datum,
       :time => :Uur,
       :note => :Nota
    })
    
  end
  
  def load_show_type
    do_load(ShowType, Old::VoorstellingenSoort, 
    {
      :name => [:VoorstellingenSoort, 'show_types']
    })
  end
  
  def load_venue
    do_load(Venue, Old::Ruimte,
    {
       :name => :Ruimte,
       :address => :Adres,
       :postal_code => :Postcode,
       :city => :Stad,
       :country => [Country, :IsoLandcode],
       :temporary_location => :TijdelijkeLocatie,
       :address_manager => :AdresBeheerder,
       :phone => :Telefoon,
       :fax => :Fax,
       :default_start_hour => :DefaultBeginUur,
       :email => :Email,
       :url => :URL,
       :note => :Nota
    })
    
    Venue.all(:conditions => ['address_manager = ?', true]).each do |venue|
      org_ruimte = Old::OrganisatieBijRuimte.find_by_RuimteId(venue.old_id)
      if org_ruimte.nil?
        log_error("Not found: Venue(#{venue.old_id}) is an address_manager, but no Old::OrganisatieBijRuimte with that RuimteID was found.")
      else
        org = Old::MasterOrganisatie.find(org_ruimte.OrganisatieId)
        venue.address = org.Adres
        venue.postal_code = org.Postcode
        venue.city = org.Stad
        venue.country_id = fetch_id(Country, org.Land)
        venue.url = org.URL
      
        link = Old::MasterLink.first(:conditions => {:OrganisatieId => org.id, :FunctieOmschrijving => 'reservatie'})
        if link
          venue.phone = link.Telefoon
          venue.fax = link.Fax
          venue.email = link.Email
        end
        venue.save(false)
      end
    end
  end
  
  def load_ico_title
    do_load(IcoTitle, Old::IcoTitel, 
    {
      :ico_type => [IcoType, :IcoTypeId],
      :title => :Titel,
      :description_nl => :Beschrijving,
      :date => :Datum,
      :season => [Season, :Seizoen],
      :copyright => :Copyright,
      :donation => [Donation, :VerwervingsId],
      :archive_part => [ArchivePart, :ArchiefBestanddeelId],
      :number_of_objects => :AantalObjecten,
      :library_location => :Vindplaats,
      :available => '!NietBeschikbaar',
      :note => :Nota
    })
    
    log_progress 'Loading part_of_ico_title information...'
    Old::IcoTitel.find(:all, :conditions => 'DeelVanIcoTitelId is not null').each do |old|
      n = IcoTitle.find_by_old_id(old.id)
      n.part_of_ico_title_id = fetch_id(IcoTitle, old.DeelVanIcoTitelId)
      if NOT_FOUND == n.part_of_ico_title_id
        log_not_found(old, :DeelVanIcoTitelId, IcoTitle)
      end

      n.save(false)
    end
    log_progress 'Done loading part_of_ico_title information...'
  end
  
  def load_ico_type
    do_load(IcoType, Old::IcoType,
    {
      :description => [:IcoType, 'ico_types']
    })
  end
  
  def load_function
    clazz = Old::FunctiesPersonen
    log_progress clazz.column_names.inspect
    hierarchy_column = clazz.column_names.find{|name| name =~ /Hi.*/}
    
    do_load(PersonFunction, Old::FunctiesPersonen, 
      {
        :name => [:Functie, 'functions_producers'],
        :marc => :MARC,
        :marc_code => :MARCCode,
        :hierarchy => hierarchy_column
      })
    do_load(OrganisationFunction, Old::FunctiesOrganisaties,
      {
        :name => [:Functie, 'functions_producers']
      })
  end
  
  def load_date_isaar
    load_throttled(Old::DatumIsaar) do |old|
      d,m,y = if old.DatumExact
                old.DatumExact.split('/')
              else
                [old.Dag, old.Maand, old.jaar]
              end
      n = DateIsaar.new(
                  :day => d,
                  :month => m,
                  :year => y,
                  :state => old.DatumStatus,
                  :source => old.DatumBron
      )
      stamp(n, old)
      n.save(false)

      notes = [old.Nota]
      attach_postits(n, notes)
      
      if !old.PersoonId.nil?
        person = fetch(Person, old.PersoonId, true)
        if person.nil?
          log_error "Missing Person with old_id #{old.PersoonId} (referenced by DatumIsaar with old_id #{old.id})"
        else
          if old.DatumSoort == 'Geboortedatum'
            person.birthdate = n
          elsif (old.DatumSoort == 'Sterfdatum') || old.DatumSoort == 'sterftedatum'
            person.death_date = n
          else
            log_error "Invalid DatumSoort (#{old.DatumSoort}) for DatumIsaar with id #{old.id}"
          end
          person.save(false)
        end
      elsif !old.OrganisatieId.nil?
        organisation = fetch(Organisation, old.OrganisatieId, true)
        if organisation.nil?
          log_error "Missing Organisation with old_id #{old.OrganisatieId} (referenced by DatumIsaar with old_id #{old.id})"
        else
          assign_organisational_date_isaar(old, organisation, n)
        end
      elsif !old.OrganisatiesRelatiesId.nil?
        organisation_relation = fetch(OrganisationRelation, old.OrganisatiesRelatiesId, true)
        if organisation_relation.nil?
          log_error "Missing OrganisationRelation with old_id #{old.OrganisatiesRelatiesId} (referenced by DatumIsaar with old_id #{old.id})"
        else
          assign_organisational_date_isaar(old, organisation_relation, n)
        end
      else
        raise StandardError.new("No PersoonId, OrganisatieId or OrganisatieRelatiesId specified for DatumIsaar with id #{old.id}")
      end
    end
  end

  def assign_organisational_date_isaar(old, org, n)
    if old.DatumSoort == 'Begindatum'
      org.creation_date = n
    elsif old.DatumSoort == 'Einddatum'
      org.cancellation_date = n
    elsif old.DatumSoort == 'Begindatum actief'
      org.start_activities_date = n
    elsif old.DatumSoort == 'Einddatum actief'
      org.end_activities_date = n
    else
      log_error "Invalid DatumSoort (#{old.DatumSoort}) for DatumIsaar with id #{old.id}"
    end
    org.save(false)
  end
  
  def load_alumnus
    do_load(Alumnus, Old::Alumnus, 
          {
            :organisation => [Organisation, :OrganisatieId],
            :person => [Person, :PersoonId],
            :start_year => :Startjaar,
            :end_year => :Eindjaar,
            :details => :Nota
          })
  end
  
  def load_audio_video_title_on_medium
    do_load(AudioVideoTitleOnMedium, Old::AvTitelOpDrager,
                {
                 :audio_video_title => [AudioVideoTitle, :AVTitelId],
                 :audio_video_medium => [AudioVideoMedium, :AVDragerId],
                 :player_position => :PlayerPositie,
                 :quality => :TitelKwaliteit,
                 :source => [Organisation, :Bron],
                 :date => :DatumOpname
                })
  end
  
  def load_festival
    do_load(Festival, Old::OrganisatieFestival, 
              {
                :organisation => [Organisation, :OrganisatieId],
                :periodicity => :FestivalPeriodiciteit,
                :start => :FestivalBegin,
                :start_text => :BeginTekst,
                :stop => :FestivalEinde,
                :stop_text => :EindeTekst,
                :type => :FestivalSoort,
                :note => :Nota
              })
  end
  
  def load_grant
    do_load(Grant, Old::Subsidie, 
            {
               :grant_state => [GrantState, :AanvraagToewijzing],
               :grant_system => [GrantSystem, :SubsidieSysteemId],
               :person => [Person, :PersoonId],
               :organisation => [Organisation, :OrganisatieId],
               :period => :Periode,
               :production => [Production, :ProductieId],
               :note => :Nota
            })
  end
  
  def load_grant_state
    GrantState.new(:description_nl => 'Aanvraag', :description_fr => 'Application', :description_en => 'Application').save(false)
    GrantState.new(:description_nl => 'Toewijzing', :description_fr => 'Approuvé', :description_en => 'Awarded').save(false)
  end
  
  def load_grant_system
    do_load(GrantSystem, Old::SubsidieSysteem, 
            {:code => :Code,
            :description => :Omschrijving,
            :legal_base => :WettelijkeBasis,
            :type => :Type,
            :grant_genre => [GrantGenre, :SubsidieGenreId],
            :organisation_form => :Organisatievorm,
            :note => :Nota
            })
  end
  
  def load_grant_genre
    do_load(GrantGenre, Old::SubsidieGenre, {
                :description => :Omschrijving,
                :note => :Nota
      })
  end
  
  def load_production_language
    do_load(ProductionLanguage, Old::ProductieTaal, {
           :production => [Production, :ProductieId],
           :language => [Language, :IsoTaalcode],
           :language_role => [LanguageRole, :Taalnota]
      } )
  end
  
  def load_production
    do_load(Production, Old::Productie, {
                      :title => :ProductieTitel,
                      :inspiration => :InspiratieNR,
                      :season => [Season, :Seizoen],
                      :target_audience_text_nl => :DoelgroepTekst,
                      :target_audience_from => :DoelgroepVan,
                      :target_audience_to => :DoelgroepTot,
                      :verified => '!NietGeverifieerd',
                      :note => :Nota
      })

    total_reruns = Old::Productie.count(:conditions => 'HernemingVan is not null')
    log_progress 'Loading #{total_reruns} rerun_of information...'
    i=0
    Old::Productie.find(:all, :conditions => 'HernemingVan is not null').each do |old|
      n = Production.find_by_old_id(old.id)
      n.rerun_of_id = fetch_id(Production, old.HernemingVan)
      if NOT_FOUND == n.rerun_of_id
        log_not_found(old, :HernemingVan, Production)
      else
        n.save(false)
      end
      i += 1
      if (i % 100) == 0
        log_progress "Loaded #{i} reruns (of #{total_reruns})"
      end
    end
    log_progress 'Done loading rerun_of information...'
  end
  
  def load_country
    ### LandCode
    Old::LandCode.find(:all).each do |old|
      Country.new(
                  :iso_code => old.IsoLandCode,
                  :name_en => old.LandEngels,
                  :name_nl => old.LandNederlands,
                  :name_fr => old.LandFrans
      ).save(false)
    end
  end
  
  def load_ephemerum_language
    do_load(EphemerumLanguage, Old::DocuTaalcode, {
                  :ephemerum => [Ephemerum, :DocuId],
                  :language => [Language, :IsoTaalcode]
      })
  end
  
  def load_ephemerum
    do_load(Ephemerum, Old::Documentatie, {
               :ephemerum_type => [EphemerumType, :DocuTypeId],
               :title => :Titel,
               :source => [Organisation, :BronId],
               :donation => [Donation, :VerwervingId],
               :warehouse => [Warehouse, :MagazijnId],
               :date => :Datum,
               :season => [Season, :Seizoen],
               :library_location => :Vindplaats,
               :available => '!NietBeschikbaar',
               :note => :Nota
      })
  end
  
  def load_ephemerum_type
    do_load(EphemerumType, Old::DocuType,
              {
                :name => :DocuType,
                :description => [:Beschrijving, 'document_types']
              }, 
              ['DocuTypeId = ? or DocuTypeId = ?', 6, 16])
    
  end
  

  def load_book_title_language
    do_load(BookTitleLanguage, Old::BoekTitelTaalcode, {
              :book_title => [BookTitle, :BoekTitelId],
              :language => [Language, :IsoTaalcode],
              :language_role => [LanguageRole, :Taalnota]
      })
  end
  
  def load_book_title_impressum
    do_load(BookTitleImpressum, Old::BoekTitelImpressum, {
                  :book_title => [BookTitle, :BoekTitelId],
                  :impressum => [Impressum, :ImpressumId]
      })
  end
  
  def load_book_copy
    do_load(BookCopy, Old::BoekExemplaar, {
             :book_title => [BookTitle, :BoekTitelId],
             :donation => [Donation, :VerwervingId],
             :library_location => :VindplaatsBibliotheek,
             :warehouse => [Warehouse, :MagazijnId],
             :borrowable => :Uitleenbaar,
             :available => '!NietBeschikbaar',
             :note => :Nota,
             :barcode => :BoekExemplaarId
      })
  end
  
  def load_book_title
    do_load(BookTitle, Old::BoekTitel, {
         :title => :BoekTitel,
         :title_extra => :BoekTitelExtra,
         :publication_year => :JaarVanUitgave,
         :ean => :EAN,
         :collation => :Collatie,
         :note => :Nota,
         :issn => :Issn,
         :subscription_running => :AboLopend,
         :subscription_type => :AboType,
         :subscription_expiration_date => :Vervaldatum,
         :number_count => :AantalNummers,
         :subscription_note => :AboNota
      })

#      if title.publication_year && (title.publication_year < 1000)
#        title.publication_year = nil
#      end

    log_progress 'Loading part_of_book_title information...'
    Old::BoekTitel.find(:all, :conditions => 'DeelVanBoekTitelId is not null').each do |old|
      title = BookTitle.find_by_old_id(old.id)
      if title.nil?
        msg = "BoekTitel met #{Old::BoekTitel.primary_key} = #{old.id} bestaat niet -- waarschijnlijk niet correct geladen."
        log_error msg
      else
        part_of_book_title_id = fetch_id(BookTitle, old.DeelVanBoekTitelId)
        if NOT_FOUND == part_of_book_title_id
          log_not_found(old, :DeelVanBoekTitelId, BookTitle)
        else
          title.part_of_book_title_id = part_of_book_title_id
          title.save(false)
        end
      end
    end
    log_progress 'Done loading part_of_book_title information...'
  end
  
  def load_archive_part
    do_load(ArchivePart, Old::ArchiefBestanddeel, {
                       :title => :Titel,
                       :donation => [Donation, :VerwervingsId],
                       :note => :Nota,
                       :warehouse => [Warehouse, :MagazijnId],
                       :classification_code => :Classeringscode
      } )
  end
  
  def load_audio_video_language
    load_throttled(Old::AvTaalcode) do |old|
      title_id = fetch_id(AudioVideoTitle, old.AVTitelId)
      if NOT_FOUND == title_id
        log_not_found(old, :AVTitelId, AudioVideoTitle)
      else
        language_id = fetch_id(Language, old.IsoTaalcode)
        if NOT_FOUND == language_id
          log_not_found(old, :IsoTaalcode, Language)
        else
          al = AudioVideoLanguage.new(
                        :audio_video_title_id => title_id,
                        :language_id => language_id)

          nota = old.Taalnota
          unless nota.nil?
            al.language_role = fetch(LanguageRole, nota)
          end

          stamp(al, old)
          al.save(false)
        end
      end
    end
  end
  
  def load_audio_video_title
    load_throttled(Old::AvTitel) do |old|
      n = AudioVideoTitle.new(
              :title => old.Titel,
              :description_nl => old.Beschrijving,
              :creation_date_text => old.DatumCreatieTekst,
              :duration_minutes => old.DuurMin,
              :copyright => old.Copyright
              )
              
      n.creation_date = if old.DatumCreatie
                  DateIsaar.create_from_date(old.DatumCreatie)
              elsif old.Jaartal || old.Maand
                  DateIsaar.create(:year => old.Jaartal, :month => old.Maand)
              end
      
      stamp(n, old)
      n.save(false)

      notes = [old.Nota]
      attach_postits(n, notes)
    end
  end
  
  def load_audio_video_medium
    do_load(AudioVideoMedium, Old::AvDrager, {
         :audio_video_medium_type => [AudioVideoMediumType, :AVDragerTypeId],
         :date => :DatumDrager,
         :donation => [Donation, :VerwervingId],
         :library_location => :VindplaatsBibliotheek,
         :warehouse => [Warehouse, :MagazijnId],
         :available => '!NietBeschikbaar',
         :technical_note => :NotaTechnisch,
         :general_note => :NotaAlgemeen,
         :barcode => :AVDragerId
      })
    
    log_progress 'Loading copy_of information...'
    Old::AvDrager.find(:all, :conditions => 'KopieVan is not null').each do |old|
      medium = AudioVideoMedium.find_by_old_id(old.AVDragerId)
      if medium.nil?
        log_error "AudioVideoMedium with old_id #{old.AVDragerId} not found (is used as KopieVan for AVDrager with id #{old.idd})"
      else
        medium.copy_of = AudioVideoMedium.find_by_library_location(old.KopieVan)
        medium.save(false)
      end
    end
    log_progress 'Done loading copy_of information...'
  end
  
  def load_article_language
    # do_load(ArticleLanguage, Old::ArtikelTaalcode, {
    #             :article => [Article, :ArtikelId],
    #             :language => [Language, :IsoTaalcode],
    #             :language_role => [LanguageRole, :Taalnota]
    #   })
    last_id = 0
    
    start_time = Time.now
    count = 0
    
    while true
      query = "select top 100 * from ArtikelTaalcodes where ArtikelTaalcodesId > #{last_id} order by ArtikelTaalcodesId "
      rows = Old::ArtikelTaalcode.connection.select_all(query)
      if rows.empty?
        break
      end
      rows.each do |row|
        last_id = row['ArtikelTaalcodesId']
        if (article_id = fetch_id(Article, row['ArtikelId'])) && (article_id != NOT_FOUND)
          language_id = fetch_id(Language, row['IsoTaalcode'])
          if language_id == NOT_FOUND
            log_error("Language with old_id #{row['IsoTaalcode']} not found.")
          else
            language_role_id = fetch_id(LanguageRole, row['Taalnota'])
            
            creator_id = fetch_id(User, row['InvoerUser'])
            updater_id = fetch_id(User, row['WijzigUser'])
            
            ArticleLanguage.connection.update("insert into article_languages (article_id, language_id, language_role_id, creator_id, updater_id, old_id) values (#{article_id}, #{language_id}, #{language_role_id.nil? ? 'NULL' : language_role_id}, #{creator_id}, #{updater_id}, #{row['ArtikelTaalcodesId']})")
          end
        elsif (press_cutting_id = fetch_id(PressCutting, row['ArtikelId'])) && (press_cutting_id != NOT_FOUND)
          language_id = fetch_id(Language, row['IsoTaalcode'])
          if (language_id == NOT_FOUND) || language_id.blank?
            log_error("Language with old_id #{row['IsoTaalcode']} not found.")
          else
            language_role_id = fetch_id(LanguageRole, row['Taalnota'])
            
            creator_id = fetch_id(User, row['InvoerUser'])
            updater_id = fetch_id(User, row['WijzigUser'])
            
            PressCuttingLanguage.connection.update("insert into press_cutting_languages (press_cutting_id, language_id, language_role_id, creator_id, updater_id, old_id) values (#{press_cutting_id}, #{language_id}, #{language_role_id.nil? ? 'NULL' : language_role_id}, #{creator_id}, #{updater_id}, #{row['ArtikelTaalcodesId']})")
          end
        else
          log_error("ArtikelTaalcode with ArtikelTaalcodesId #{row['ArtikelTaalcodesId']} has an ArtikelId that is neither an Article nor a PressCutting.")
        end
        
        count += 1
        if (count % 1000 == 0)
          log_progress("Processed #{count} ArticleLanguages in #{Time.now - start_time} s (Average speed: #{(Time.now - start_time) / count} s per record)")
        end
      end
    end
  end

  def load_press_cutting_language
    # do_load(PressCuttingLanguage, Old::ArtikelTaalcode, {
    #             :press_cutting => [PressCutting, :ArtikelId],
    #             :language => [Language, :IsoTaalcode],
    #             :language_role => [LanguageRole, :Taalnota]
    #   })
  end
  
  def load_audio_video_medium_type
    do_load(AudioVideoMediumType, Old::AvDragerType,
              { :description => [:AVDragerType, 'AV_medium_types']}    
            )
  end
  
  def load_press_cutting
    do_load(PressCutting, Old::Artikel,
              {
                :title => :ArtikelTitel,
                :date => :ArtikelDatum,
                :periodical => [Periodical, :TijdschriftId],
                :library_location => :Referentie,
                :available => '!NietBeschikbaar',
                :note => :Nota
              }, 
              ['DocuTypeId = ?', 8])
  end
  
  def load_article
    do_load(Article, Old::Artikel,
              {
                :title => :ArtikelTitel,
                :periodical_issue => [PeriodicalIssue, :TijdschriftExemplaarId],
                :reference => :Referentie,
                :available => '!NietBeschikbaar',
                :note => :Nota
              }, 
              ['DocuTypeId = ?', 11])
  end
  
  def load_periodical_language
    do_load(PeriodicalLanguage, Old::TijdschriftTaalcode,
        {
          :periodical => [Periodical, :TijdschriftID],
          :language => [Language, :IsoTaalcode],
          :language_role => [LanguageRole, :Taalnota]
        })
  end
  
  def load_periodical_issue
    do_load(PeriodicalIssue, Old::TijdschriftExemplaar,
                {
                    :title => :Titel,
                    :periodical => [Periodical, :TijdschriftID],
                    :volume => :Jaargang,
                    :number => :Nummer,
                    :date_text => :DatumTekst,
                    :search_date => :Zoekdatum,
                    :library_location => :BibliotheekVindplaats,
                    :warehouse => [Warehouse, :MagazijnID],
                    :donation => [Donation, :VerwervingId],
                    :note => :Nota,
                    :available => '!NietBeschikbaar',
                    :barcode => :TijdschriftExemplaarID
                })
    
    log_progress 'Loading part_of_issue information...'
    Old::TijdschriftExemplaar.find(:all, :conditions => 'DeelVanExemplaarID is not null').each do |old|
      issue = PeriodicalIssue.find_by_old_id(old.TijdschriftExemplaarID)
      issue.part_of_issue_id = fetch_id(PeriodicalIssue, old.DeelVanExemplaarID)
      if NOT_FOUND == issue.part_of_issue_id
        log_not_found(old, :DeelVanExemplaarID, PeriodicalIssue)
      else
        issue.save(false)
      end
    end
    log_progress 'Done loading part_of_copy information...'
  end
  
  def load_warehouse
    do_load(Warehouse, Old::Magazijn, {
        :box_type => [BoxType, :Boxtype],
        :box_location => :BoxPlaats,
        :barcode => :MagazijnID
      })
  end
  
  def load_box_type
    do_load(BoxType, Old::Boxtype,
              {
                :description => [:Beschrijving, 'box_types']
              })
  end
  
  def load_periodical_impressum
    do_load(PeriodicalImpressum, Old::TijdschriftImpressum, {
        :impressum => [Impressum, :ImpressumId],
        :periodical => [Periodical, :TijdschriftId]
      })
  end
  
  # Load and cache Impressums
  def load_impressum
    do_load(Impressum, Old::Impressum,
                {
                    :code => :ImpressumCode,
                    :publisher => :Uitgever,
                    :publish_location => :Uitgaveplaats,
                    :note => :Nota
                })
  end
  
  def load_periodical
    # log_progress sizes_information(Old::Tijdschrift).inspect
    do_load(Periodical, Old::Tijdschrift,
                {
                    :antilope_index => :AntilopeNummer,
                    :title => :Titel,
                    :title_extra => :TitelExtra,
                    :url => :Omschrijving,
                    :issn => :Issn,
                    :periodical_note => :TijdschriftNota,
                    :holdings => :Holdings,
                    :subscription_type => :AboType,
                    :subscription_periodicity => :AboPeriodiciteit,
                    :subscription_running => :AboLopend,
                    :subscription_end_date => :AboVervaldatum,
                    :subscription_note => :AboNota
                })
  end
  
  def load_donation
    do_load(Donation, Old::Verwerving,
                {
                      :code => :VerwervingsCode,
                      :title => :Titel,
                      :donation_date => :VerwervingsDatum,
                      :ex_dono => :ExDono,
                      :person => [Person, :PersoonID],
                      :organisation => [Organisation, :OrganisatieID],
                      :donor_person => [Person, :SchenkerPersId],
                      :donor_organisation => [Organisation, :SchenkerOrgId],
                      :size => :Omvang,
                      :content => :Inhoud,
                      :date_info => :Datering,
                      :note => :Nota
                })
  end
  
  def load_organisation
    do_load(Organisation, Old::MasterOrganisatie, {
         :name => :Organisatienaam,
         :language => [Language, :Taal],
         :url => :URL,
         :publicid => :PubliekId,
         :country => [Country, :Land],
         :city => :Stad,
         :legal_form => [LegalForm, :JuridischeVorm]
      })

    log_progress "Loading #{Old::Classeringscode.count} Classeringscodes"
    Old::Classeringscode.all.each do |old|
      organisation = Organisation.find_by_old_id(old.OrganisatieId)
      if organisation.nil?
        log_not_found(old, :OrganisatieId, Organisation)
      else
        organisation.classification_code = old.Classeringscode
        organisation.save(false)
      end
    end
    log_progress "Classeringscodes loaded"

  end
  
  def load_person
    # hsh = {:last_name => :Familienaam,
    #         :first_name => :Voornaam,
    #         :gender => [Gender, :Geslacht],
    #         :language => [Language, :Taal],
    #         :publicid => :PubliekId,
    #         :country => [Country, :Land],
    #         :city => :Stad}
    #         
    # 
    # last_id = 0
    # 
    # start_time = Time.now
    # count = 0
    # 
    # attributes = {}
    # references = []
    # 
    # hsh.each_pair do |key, value|
    #   if value.is_a? Array
    #     references[]
    #   else
    #   end
    # end
    # 
    # while true
    #   query = "select top 100 * from MasterPersoon where PersoonId > #{last_id} order by PersoonId"
    #   rows = Old::MasterPersoon.connection.select_all(query)
    #   if rows.empty?
    #     break
    #   end
    #   rows.each do |row|
    #     last_id = row['PersoonId']
    #         
    #     creator_id = fetch_id(User, row['InvoerUser'])
    #     updater_id = fetch_id(User, row['WijzigUser'])
    # 
    #         
    #     Person.connection.update("insert into people (article_id, language_id, language_role_id, creator_id, updater_id, old_id) values (#{article_id}, #{language_id}, #{language_role_id.nil? ? 'NULL' : language_role_id}, #{creator_id}, #{updater_id}, #{row['ArtikelTaalcodesId']})")
    #     
    #     count += 1
    #     if (count % 1000 == 0)
    #       log_progress("Processed #{count} ArticleLanguages in #{Time.now - start_time} s (Average speed: #{(Time.now - start_time) / count} s per record)")
    #     end
    #   end
    # end
    
    
    
    do_load(Person, Old::MasterPersoon, {
           :last_name => :Familienaam,
           :first_name => :Voornaam,
           :gender => [Gender, :Geslacht],
           :language => [Language, :Taal],
           :publicid => :PubliekId,
           :country => [Country, :Land],
           :city => :Stad
      })
    Person.all(:conditions => 'last_name is null and first_name is null').each do |person|
      person.delete
    end
    
    load_throttled(Old::PersonenIsaar) do |isaar|
      person = fetch(Person, isaar.PersoonId)
      person.update_attributes(:key_name => isaar.Sleutelnaam, :alias_of_id => fetch_id(Person, isaar.AliasVanPersoonId))
      person.update_attributes(:country_id => fetch_id(Country, isaar.IsoLandcode)) unless isaar.IsoLandcode.nil?
                                
      if isaar.Nota
        notes = [isaar.Nota]
        attach_postits(person, notes)
      end
    end
  end
  
  def load_legal_form
    do_load(LegalForm, Old::JuridischeVorm,
              {:name => [:JuridischeVorm, 'legal_forms']})
  end

  def load_gender
    Gender.new(:code => 'F', :name_nl => 'Vrouw', :name_fr => 'Femme', :name_en => 'Female').save(false)
    Gender.new(:code => 'M', :name_nl => 'Man', :name_fr => 'Homme', :name_en => 'Male').save(false)
  end
    
  def load_language
    ### TAALCODE
    Old::TaalCode.find(:all).each do |tc|
      Language.new(:iso_code => tc.IsoTaalCode, 
                   :name_en => tc.TaalEngels,
                   :name_nl => tc.TaalNederlands,
                   :name_fr => tc.TaalFrans).save(false)
    end
  end

  def load_user
    load_throttled(Old::VtiUser) do |old|
      u = User.new(:login => old.LoginName,
              :name => old.UserName,
              :identity_url => old.LoginName,
              :admin => false)
      if old.respond_to?('OpenID')
        u.identity_url = old.OpenID unless old.OpenID.nil?
        u.admin = true
      end
      u.old_id = old.id
      u.save(false)
    end
    
    User.new(:identity_url => 'http://tomklaasen.net/', :email => 'tom@10to1.be', :admin => true).save(false)
    User.new(:identity_url => 'http://atog.be/', :email => 'koen@10to1.be', :admin => true).save(false)
    User.new(:identity_url => 'http://maxvoltar.myopenid.com/', :email => 'tim@madebyelephant.com', :admin => true).save(false)
    User.new(:identity_url => 'http://openid.vti.be/tom', :email => 'openid.vti@tomk.be', :admin => true).save(false)
    
#    dries = User.find_by_name 'Dries Moreels'
#    dries.update_attributes(:identity_url => 'http://cumont.myopenid.com/', :email => 'dries@vti.be')
#    dries.save!
  end
  
  ### Cache methods
  def fill_id_cache_for_language
    result = Hash.new
    Language.find(:all).each do |l|
      result[l.iso_code] = l.id
    end
    result['dut'] = result['DUT']
    result['dyt'] = result['DUT']
    result['Dut'] = result['DUT']
    result['nl'] = result['DUT']
    result['ned'] = result['DUT']
    result['NED'] = result['DUT']
    result['NL'] = result['DUT']
    result['nl'] = result['DUT']
    result['NL '] = result['DUT']
    result['nl '] = result['DUT']
    result['fre'] = result['FRE']
    result['Fre'] = result['FRE']
    result['Fe'] = result['FRE']
    result['eng'] = result['ENG']
    result
  end

  def fill_id_cache_for_country
    result = Hash.new
    Country.find(:all).each do |l|
      result[l.iso_code] = l.id
    end
    result['be'] = result['BE']
    result['Be'] = result['BE']
    result['nl'] = result['NL']
    result['fr'] = result['FR']
    result['cz'] = result['CZ']
    result['za'] = result['ZA']
    result
  end

  def fill_id_cache_for_gender
    result = {'M' => Gender.find_by_code('M').id, 'V' => Gender.find_by_code('F').id}
    result['m'] = result['M']
    result['v'] = result['V']
    result
  end

  def fill_id_cache_for_grant_state
    {'A' => GrantState.find_by_description_nl('Aanvraag').id, 'T' => GrantState.find_by_description_nl('Toewijzing').id}
  end


  def cache_language
    language_cache = Hash.new
    Language.find(:all).each do |l|
      language_cache[l.iso_code] = l
    end
    language_cache
  end
  
  def cache_country
    country_cache = Hash.new
    Country.find(:all).each do |c|
      country_cache[c.iso_code] = c
    end
    country_cache
  end
  
  def cache_gender
    {'M' => Gender.find_by_code('M'), 'V' => Gender.find_by_code('F')}
  end
  
  def cache_grant_state
    {'A' => GrantState.find_by_description_nl('Aanvraag'), 'T' => GrantState.find_by_description_nl('Toewijzing')}
  end
  
  def cache_user
    result = Hash.new
    User.find(:all).each do |user|
      result[user.old_id] = user unless user.old_id.nil?
    end
    result
  end

  ### Helper methods
  
  def stamp(n, old)
    begin
      n.created_at =
        if old.respond_to? 'InvoerDatum'
          old.InvoerDatum
        elsif old.respond_to? 'Invoerdatum'
          old.Invoerdatum
        end
      n.created_at = Time.now if n.created_at.nil?
      
      n.updated_at =
        if old.respond_to? 'WijzigDatum'
          old.WijzigDatum
        elsif old.respond_to? 'Wijzigdatum'
          old.Wijzigdatum
        end
      n.updated_at = Time.now if n.updated_at.nil?

      n.creator_id = fetch_id(User, old.InvoerUser) if old.respond_to?("InvoerUser")
      n.updater_id = fetch_id(User, old.WijzigUser) if old.respond_to?("WijzigUser")
      n.old_id = old.id
    rescue StandardError => bang
      log_error "Error while stamping #{n.inspect}: #{bang.backtrace.join("\n")}"
    end
  end
  
  def create_old_id(clazz)
    atomic_create_old_id(clazz)
    
    if clazz.respond_to? 'versioned_class'
      atomic_create_old_id(clazz.versioned_class)
    end
  end
  
  def atomic_create_old_id(clazz)
    begin
      clazz.connection.add_column(clazz.table_name, 'old_id', 'integer')
    rescue StandardError
#      log_error "Couldn't create old_id column for #{clazz}. It probably already existed."
    end
  end

  def remove_old_id(clazz)
    atomic_remove_old_id(clazz)

    if clazz.respond_to? 'versioned_class'
      atomic_remove_old_id(clazz.versioned_class)
    end
  end
  
  def atomic_remove_old_id(clazz)
    begin
      clazz.connection.remove_column(clazz.table_name, 'old_id')
    rescue StandardError
      # No sweat
    end
  end
  
  def reload!
    log_progress "Reloading..."
    dispatcher = ActionController::Dispatcher
    dispatcher.cleanup_application
    dispatcher.reload_application
    true
  end
  
  def sizes_information(clazz)
    sizes = {}
    clazz.find(:all).each do |object|
#      begin
        object.attributes.each do |attribute, value|
          if value.is_a? String
            old = sizes[attribute] || 0
            current = value ? value.size : 0
            sizes[attribute] = [old, current].max
          end
        end
#      rescue => bang
#        log_error bang
#      end
    end
    sizes
  end
  
  def load(clz)
    start = Time.now
    
    clz_underscored = "#{clz}".underscore
    self.send "load_#{clz_underscored}"
    time_lapsed = Time.now - start
    log_progress "#{clz.count} #{clz.table_name} loaded in #{time_lapsed} s"
  end
  
  def delete(clz)
    clz.delete_all
    if clz.respond_to? 'versioned_class'
      clz.versioned_class.delete_all
    end
    log_progress "#{clz.table_name} deleted"
  end
  
  def load_throttled_with_model(old_clazz, conditions = nil)
    total = old_clazz.count
    # transaction_clazz = new_clazz || ActiveRecord::Base
    transaction_clazz = ActiveRecord::Base
    log_progress
    log_progress "Going to import #{total} instances of #{old_clazz.to_s}"
    offset = 0
    limit = 100
    until (results = old_clazz.find(:all, 
                                    :conditions => conditions,
                                    :limit => limit, 
                                    :offset => offset, 
                                    :order => old_clazz.primary_key)).empty?
      start = Time.now
      transaction_clazz.transaction do
        results.each do |old|
          yield old
        end
      end
      eind = Time.now
      time_lapsed = eind - start
      log_progress "  #{old_clazz.to_s} #{offset} - #{offset + results.size - 1} (of #{total}) loaded in #{time_lapsed} s (Average speed: #{time_lapsed / results.size}s per record)"
      offset += limit
    end
  end
  
  def do_load_with_model(new_clazz, old_clazz, attribute_map, conditions = nil)
    @note_fields ||= %w(note general_note technical_note periodical_note)

    has_migration_flag = old_clazz.column_names.include?('MigratieNaarPostgres')

    load_throttled_with_model(old_clazz, conditions) do |old|
      if has_migration_flag && !old.MigratieNaarPostgres
        # do nothing
      else
        attributes = Hash.new
        notes = []
        attribute_map.each do |key, value|
          if @note_fields.include? key.to_s 
            note = old.send(value.to_s)
            notes << note 
          elsif key.to_s == 'barcode'
            attributes[key] = new_clazz.barcode_for(old.send(value.to_s))
          elsif value.is_a? Array
            if value[0].is_a?(Class)
              # Foreign key
              v =  old.send(value[1].to_s)
              unless v.nil?
                 new_id = fetch_id(value[0], v)
                 if NOT_FOUND == new_id
                   if value[0].name == 'Article'
                     # do nothing: maybe it references a PressCutting
                   elsif value[0].name == 'PressCutting'
                     if fetch_id(Article, v) == NOT_FOUND
                       log_not_found(old, value[1], value[0])
                     end
                   else
                     log_not_found(old, value[1], value[0])
                   end
                 else
                   attributes["#{key}_id"] = new_id
                 end
              end
            else
              # Localized field.
              # e.g. :description => [:Beschrijving, 'box_types']
              nl = old.send(value[0].to_s)
              context = value[1].to_s
              attributes["#{key}_nl"] = nl
              attributes["#{key}_fr"] = translate(nl, context, :fr)
              attributes["#{key}_en"] = translate(nl, context, :en)
            end
          elsif (value.is_a? String) && (value[0..0] == '!')
            attributes[key] = !old.send(value[1..-1])
          else
            attributes[key] = old.send(value.to_s)
          end
        end

        n = new_clazz.new(attributes)
        stamp(n, old)
        if n.save(false)
          attach_postits(n, notes)
        else
          msg = 
            if (new_clazz == BookTitle) && n.errors.on(:ean)
              "Could not save the BookTitle for BoekTitel with #{Old::BoekTitel.primary_key} = #{n.old_id}. EAN #{n.ean} is not valid."
            else
              "Could not save #{n.inspect}: #{n.errors.inspect}"
            end
          log_error msg
        end
      end
    end
  end
  
  def translate(nl, context, target_lang)
    @translations ||= {}
    if @translations[context].nil?
      dict = @translations[context] = {}
      Old::VertaalTabel.all(:conditions => ['Context = ?', context]).each do |vertaal|
        dict[vertaal.NL] = {:fr => vertaal.FR, :en => vertaal.EN}
      end
    end
    if @translations && @translations[context] && @translations[context][nl]
      @translations[context][nl][target_lang.to_sym]
    else
      log_error "No translation found for #{nl} in context #{context}"
    end
  end

  def load_throttled_with_sql(old_clazz, new_clazz = nil)
    connection = old_clazz.connection
    table = old_clazz.table_name
    total = connection.select_value("select count(1) from #{table}")
    
    transaction_clazz = new_clazz || ActiveRecord::Base
    log_progress
    log_progress "Going to import #{total} instances of #{old_clazz.to_s}"
    offset = 0
    limit = 100
    until (results = old_clazz.find(:all,
                                    :limit => limit,
                                    :offset => offset,
                                    :order => old_clazz.primary_key)).empty?
      start = Time.now
      transaction_clazz.transaction do
        results.each do |old|
          yield old
        end
      end
      eind = Time.now
      time_lapsed = eind - start
      log_progress "  #{old_clazz.to_s} #{offset} - #{offset + results.size - 1} (of #{total}) loaded in #{time_lapsed} s"
      offset += limit
    end
  end

  def load_throttled(old_clazz)
    load_throttled_with_model(old_clazz) do |old|
      yield old
    end
  end

  def do_load(new_clazz, old_clazz, attribute_map, conditions = nil)
    do_load_with_model(new_clazz, old_clazz, attribute_map, conditions)
  end


  def log_not_found(old_object, old_attribute, new_clazz)
     msg = "Not found: #{old_object.class}(#{old_object.class.primary_key}: #{old_object.id}) has attribute #{old_attribute} = #{old_object.send(old_attribute)}, but a #{new_clazz.name} with that old_id doesn't exist."
     log_error msg
  end

  def log_error(msg = '')
    log_progress(msg)
    @error_logger.error(Time.now.to_s + " " + msg.to_s)
    # puts msg
  end

  def log_progress(msg = '')
    @progress_logger.info(Time.now.to_s + " " + msg.to_s)
#    puts msg
  end  

  def attach_postits(n, notes)
    @postit_lang_id ||= fetch_id(Language, "DUT")
    @postit_user_id ||= testmans.id

    notes.each do |note|
      unless note.blank?
        # log.progress "Creating postit"
        postit = Postit.new(:text => note, :language_id => @postit_lang_id, :user_id => @postit_user_id)
        postit.postitable = n
        postit.save(false)
      end
    end
  end
  
  # Fix data issues
  def fix_key(clazz, old_key)
    case "#{clazz}"
    when "Language"
      old_key = old_key.upcase.strip
      old_key = 'DUT' if old_key == 'NL'
      old_key = 'DUT' if old_key == 'NED'
    when 'Gender'
      old_key = old_key.upcase.strip
      old_key = 'V' if old_key == 'F'
    when 'User'
      old_key = 1 if old_key == 0
    end
    old_key
  end

  def testmans
    @testmans ||= User.find_by_name('Jan Testmans')
  end
  
  # Fetches an object of clazz that corresponds with the old_key (a key in the Old db)
  def fetch(clazz, old_key, allow_nil = false)
    # log_progress("invoking fetch(#{clazz}, #{old_key}, #{allow_nil})")
    if "#{clazz}" == 'User' && old_key.nil?
      old_key = 1
    end
    return nil if old_key.nil?
    clazz_underscore = "#{clazz}".underscore
    result = nil
    
    if self.respond_to? "cache_#{clazz_underscore}"
      if @cache[clazz].nil?
        log_progress "Filling cache for #{clazz}"
        @cache[clazz] = self.send("cache_#{clazz_underscore}")
      end
      result = @cache[clazz][fix_key(clazz, old_key)]
    elsif "#{clazz}" == 'Season'
      result = Season.find_by_name(old_key)
      if result.nil?
        years = old_key.split('-')
        result = Season.create(:name => old_key, :start_year => years[0].to_i, :end_year => years[1].to_i)
      end
    elsif "#{clazz}" == 'Tag'
      result = Tag.find_or_create_by_name(old_key)
      result.language_id ||= fetch_id(Language, 'DUT')
    elsif "#{clazz}" == 'LanguageRole'
      result = LanguageRole.find_by_description_nl(old_key)
      if result.nil?
        result = LanguageRole.new
        result.description_nl = old_key
        result.description_en = translate(old_key, 'language_role', :en)
        result.description_fr = translate(old_key, 'language_role', :fr)
        result.save(false)
      end
    elsif count(clazz) < 1500
      unless @cache[clazz]
        new_cache = Hash.new
        clazz.all.each do |obj|
          new_cache[obj.old_id] = obj
        end
        @cache[clazz] = new_cache
      end
      result = @cache[clazz][old_key]
    else
      result = clazz.find_by_old_id(old_key)
    end
    
    raise NotFoundError if (result.nil? && !allow_nil)
    result
  end

  def fetch_id(clazz, old_key)
    @id_cache ||= Hash.new
    if "#{clazz}" == 'User' && old_key.nil?
      old_key = 1
    end
    if clazz == BoxType
      old_key = old_key.to_i
    end
    return nil if old_key.nil?
    clazz_cache = @id_cache[clazz]
    
    # log_progress("clazz_cache for #{clazz} is #{clazz_cache.nil? ? '' : 'not '}nil")
    
    if (clazz == Season) || (clazz == Tag) || (clazz == LanguageRole)
      if clazz_cache.nil?
        clazz_cache = Hash.new
        @id_cache[clazz] = clazz_cache
      end
      return (clazz_cache[old_key] ||= fetch(clazz, old_key).id)
    elsif clazz_cache.nil?
      fill_id_cache(clazz)
      clazz_cache = @id_cache[clazz]
    end
    clazz_cache[old_key] || NOT_FOUND
  end

  def fill_id_cache(clazz)
    log_progress "Filling id_cache for #{clazz}"
    clazz_cache = []
    if self.respond_to? "fill_id_cache_for_#{clazz.name.underscore}"
      clazz_cache = self.send("fill_id_cache_for_#{clazz.name.underscore}")
    else
      table = clazz.table_name
      sql = "select id, old_id from #{table}"
      conn = clazz.connection
      conn.select_all(sql).each do |row|
        old_id = row['old_id']
        clazz_cache[old_id.to_i] = row['id'].to_i unless old_id.nil?
      end
      log_progress "Cached #{clazz_cache.size} instances of #{clazz.to_s}"
    end
    @id_cache[clazz] = clazz_cache
  end

  def count(clazz)
    @object_count ||= Hash.new
    @object_count[clazz] ||= clazz.count
  end
    
  
end

class NotFoundError < StandardError
end

Migrator.new.run