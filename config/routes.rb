ActionController::Routing::Routes.draw do |map|
  
  map.rdfschemas '/rdfschemas/:classname.:format', :controller => 'rdfschemas', :action => 'show'
#  map.rdf ":name/:id.:format", :controller => "RDF", :action => "show", :format => /rdf/

  map.resources :pdf, :controller => :pdf
  
  # BEGIN change controller => relationships to :controller => :organisation_relations
  map.resources :organisation_relations, :controller => :organisation_relations
  
  map.resources :organisation_organisation_from_organisations, :controller => :organisation_relations
  map.resources :organisation_from_organisations, :controller => :organisation_relations
  
  map.resources :organisation_organisation_to_organisations, :controller => :organisation_relations
  map.resources :organisation_to_organisations, :controller => :organisation_relations
  # END
  
  map.resources :archive_part_about_organisations, :controller => :relationships
  map.resources :archive_part_about_people, :controller => :relationships
  map.resources :archive_part_about_production, :controller => :relationships 
  map.resources :archive_parts, :collection => {:lookup => :get, :search => :post} do |document|
    document.resources :author_relations, :only => :index 
    document.resources :subject_relations, :only => :index 
  end
  map.resources :article_about_organisations, :controller => :relationships
  map.resources :article_about_genres, :controller => :relationships
  map.resources :article_about_people, :controller => :relationships
  map.resources :article_about_production, :controller => :relationships
  map.resources :article_by_organisations, :controller => :relationships
  map.resources :article_by_people, :controller => :relationships
  map.resources :articles, :collection => {:lookup => :get, :search => :post} do |document|
    document.resources :author_relations, :only => :index 
    document.resources :subject_relations, :only => :index 
  end
  map.resources :article_languages, :controller => :relationships
  map.resources :audio_video_media, :collection => {:lookup => :get, :search => :post, :stickers => :get, :reset_stickers => :get} do |audio_video_medium|
    audio_video_medium.resources :audio_video_title_on_media, :only => :index
  end
  map.resources :audio_video_title_about_organisations, :controller => :relationships
  map.resources :audio_video_title_about_people, :controller => :relationships
  map.resources :audio_video_title_about_productions, :controller => :relationships
  map.resources :audio_video_title_about_genres, :controller => :relationships
  map.resources :audio_video_title_by_organisations, :controller => :relationships
  map.resources :audio_video_title_by_people, :controller => :relationships
  map.resources :audio_video_title_on_media, :controller => :relationships
  map.resources :audio_video_languages, :controller => :relationships
  map.resources :audio_video_titles, :collection => {:lookup => :get, :search => :post} do |document|
    document.resources :author_relations, :only => :index 
    document.resources :subject_relations, :only => :index 
  end
  map.resources :book_copies, :collection => {:lookup => :get, :stickers => :get, :reset_stickers => :get}, :member => { :cloneable => :post }
  map.resources :book_title_about_organisations, :controller => :relationships
  map.resources :book_title_about_people, :controller => :relationships
  map.resources :book_title_about_genres, :controller => :relationships
  map.resources :book_title_about_productions, :controller => :relationships
  map.resources :book_title_by_organisations, :controller => :relationships
  map.resources :book_title_by_people, :controller => :relationships
  map.resources :book_title_impressums, :controller => :relationships
  map.resources :book_title_languages, :controller => :relationships
  map.resources :book_title_order, :controller => :relationships
  map.resources :book_titles, :collection => {:lookup => :get, :search => :post} do |document|
    document.resources :author_relations, :only => :index 
    document.resources :subject_relations, :only => :index 
    document.resources :book_copies,  :only => :index, :controller => :nested_book_copies
    document.resources :about_genres,  :only => :index, :controller => :nested_about_genres
    document.resources :book_title_languages,  :only => :index, :controller => :nested_book_title_languages
    document.resources :book_title_impressums,  :only => :index, :controller => :nested_book_title_impressums
  end
  map.resources :box_types, :collection => {:lookup => :get, :search => :post}
  map.resources :cdb_actors
  map.resources :cdb_addresses
  map.resources :cdb_cities
  map.resources :cdb_event_details do |cdb_event_detail|
    cdb_event_detail.resources :cdb_performers, :only => :index, :controller => :nested_cdb_performers
  end
  map.resources :cdb_events
  map.resources :cdb_locations do |cdb_location|
    cdb_location.resources :cdb_events, :only => :index, :controller => :nested_cdb_events
  end
  map.resources :cdb_organisations
  map.resources :cdb_physical_addresses
  map.resources :documents
  map.resources :donations, :collection => {:search => :post, :lookup => :get} do |donation|
    donation.resources :donors, :only => :index
    donation.resources :contains_documents, :only => :index
  end
  map.resources :ephemera, :collection => {:lookup => :get, :search => :post} do |document|
    document.resources :author_relations,    :only => :index 
    document.resources :subject_relations,   :only => :index 
    document.resources :ephemerum_languages, :only => :index 
  end
  map.resources :ephemerum_about_organisations, :controller => :relationships
  map.resources :ephemerum_about_people, :controller => :relationships
  map.resources :ephemerum_about_productions, :controller => :relationships
  map.resources :ephemerum_by_organisations, :controller => :relationships
  map.resources :ephemerum_by_people, :controller => :relationships
  map.resources :ephemerum_languages, :controller => :relationships
  map.resources :ephemerum_about_genres, :controller => :relationships
  map.resources :festivals, :collection => {:lookup => :get, :search => :post} 
  map.resources :grants
  map.resources :ico_title_about_organisations, :controller => :relationships
  map.resources :ico_title_about_people, :controller => :relationships
  map.resources :ico_title_about_genres, :controller => :relationships
  map.resources :ico_title_about_productions, :controller => :relationships
  map.resources :ico_title_by_organisations, :controller => :relationships
  map.resources :ico_title_by_people, :controller => :relationships
  map.resources :ico_titles, :collection => {:lookup => :get, :search => :post} do |document|
    document.resources :author_relations, :only => :index 
    document.resources :subject_relations, :only => :index 
  end
  map.resources :descriptions, :collection => {:lookup => :get, :search => :post}
  map.resources :impressums, :collection => {:lookup => :get, :search => :post}
  map.resources :languages, :collection => {:lookup => :get, :search => :post}  
  map.resources :orders, :collection => {:lookup => :get, :search => :post}
  map.resources :organisation_impressums, :collection => {:lookup => :get, :search => :post}
  map.resources :organisations, :collection => {:lookup => :get, :search => :post} do |organisation|
    organisation.resources :production_by_organisations, :only => :index, :collection => {:add => :post}, :member => {:delete => :delete}
    organisation.resources :author_of_documents        , :only => :index 
    organisation.resources :subject_of_documents       , :only => :index 
    organisation.resources :organisation_relations     , :only => :index, :controller => :nested_organisation_relations
    organisation.resources :grants                     , :only => :index, :controller => :nested_grants
  end
  map.resources :organisation_about_genres, :controller => :relationships
  map.resources :organisation_venues, :controller => :relationships
  map.resources :organisation_relations, :collection => {:lookup => :get}
  map.resources :people, :collection => {:lookup => :get, :search => :post} do |person|
    person.resources :production_by_people, :only => :index
    person.resources :author_of_documents, :only => :index 
    person.resources :subject_of_documents, :only => :index 
  end
  map.resources :periodicals, :collection => {:lookup => :get, :search => :post} do |periodical|
    periodical.resources :contains_documents, :only => :index
    periodical.resources :periodical_issues,  :only => :index, :controller => :nested_periodical_issues
  end
  map.resources :periodical_issues, :collection => {:lookup => :get, :stickers => :get, :reset_stickers => :get, :search => :post} do |periodical_issue|
    periodical_issue.resources :articles, :only => :index
  end
  map.resources :alumni, :collection => {:lookup => :get, :search => :post}
  map.resources :periodical_about_genres, :controller => :relationships
  map.resources :periodical_impressums, :collection => {:lookup => :get, :search => :post}
  map.resources :press_cutting_about_organisations, :controller => :relationships
  map.resources :press_cutting_about_people, :controller => :relationships
  map.resources :press_cutting_about_production, :controller => :relationships
  map.resources :press_cutting_about_genres, :controller => :relationships
  map.resources :press_cutting_by_organisations, :controller => :relationships
  map.resources :press_cutting_by_people, :controller => :relationships
  map.resources :press_cuttings, :collection => {:lookup => :get, :search => :post, :todo => :get, :without_language => :get} do |document|
    document.resources :author_relations,        :only => :index 
    document.resources :subject_relations,       :only => :index 
    document.resources :press_cutting_languages, :only => :index
  end
  map.resources :press_cutting_languages, :controller => :relationships
  map.resources :periodical_languages, :controller => :relationships
  map.resources :production_about_genres, :controller => :relationships
  map.resources :production_by_organisations, :controller => :relationships
  map.resources :production_by_people, :controller => :relationships
  map.resources :production_languages, :collection => { :lookup => :get, :search => :post }
  map.resources :genres, :collection => {:lookup => :get, :search => :post}
  map.resources :productions, :collection => {:lookup => :get, :search => :post}, :member => { :cloneable => :post} do |production|
    production.resources :production_by_organisations, :only => :index
    production.resources :production_by_people,    :only => :index
    production.resources :subject_of_documents,    :only => :index
    production.resources :production_languages,    :only => :index
    production.resources :production_about_genres, :only => :index
    production.resources :shows,                   :only => :index, :controller => :nested_shows
  end
  map.resources :venues, :collection => {:lookup => :get} do |venue|
    venue.resources :organisation_venues, :only => :index
  end
  map.resource :session, :only => [:new, :create, :destroy]
  map.resources :seasons, :collection => {:lookup => :get, :search => :post} do |season|
    [:productions, :documents].each do |rel|
      season.resources rel, :only => :index, :controller => "nested_#{rel.to_s}"
    end
  end
  map.resources :shows, :requirements => {:id => /[0-9]+/}, :member => { :cloneable => :post}
  map.resources :statics
  map.resources :users do |user|
    user.resources :postits, :only => :index
    user.resources :edits, :only => :index
  end
  map.resources :venues, :collection => {:lookup => :get, :search => :post}
  map.resources :warehouses, :collection => {:search => :post, :lookup => :get, :stickers => :get, :reset_stickers => :get} do |warehouse|
    warehouse.resources :contains_documents, :only => :index
  end

  
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'

  map.connect '/civicrm/export.:format', :controller => 'civicrm', :action => 'export', :format => /csv/

  
  # AJAX Controller
  map.fetch "/jx/:pid/:object/:id/:relation/:klazz", :controller => "ajax_box", :action => "fetch"
  
  # Tags Controller
  map.autocomplete_tags "/tags/autocomplete", :controller => "tags", :action => "autocomplete_tags"
  map.add_tags "/tags/add/:object/:id", :controller => "tags", :action => "add", :conditions => { :method => :post }
  map.delete_tags "/tags/:id/:object_class/:object_id", :controller => "tags", :action => "destroy", :conditions => { :method => :post }
  map.resources :tags do |tag|
    tag.resources :taggables, :only => :index
  end

  # organisation_relations Controller
  map.add_organisation_relation "/relationships/:relationship_type/:parent_class/:parent_id/:object_class/:object_id", :controller => 'organisation_relations', :action => 'add', :conditions => { :method => :post }
  map.delete_organisation_relation "/relationships/:relationship_type/:child_id/:parent_class/:parent_id", :controller => 'organisation_relations', :action => 'delete', :conditions => { :method => :post }

  # relationships Controller
  map.add_relationship "/relationships/:relationship_type/:parent_class/:parent_id/:object_class/:object_id", :controller => 'relationships', :action => 'add', :conditions => { :method => :post }
  map.delete_relationship "/relationships/:relationship_type/:child_id/:parent_class/:parent_id", :controller => 'relationships', :action => 'delete', :conditions => { :method => :post }  

  # Postits Controller
  map.add_postits "/postits/add/:object/:id", :controller => "postits", :action => "add", :conditions => { :method => :post }
  map.edit_postits "/postits/edit/:postit_id/:object/:id", :controller => "postits", :action => "edit", :conditions => { :method => :post }
  map.delete_postits "/postits/:id/:object_class/:object_id", :controller => "postits", :action => "destroy", :conditions => { :method => :delete }
  
  #ErrorReports Controller
  map.add_error_reports "/error_reports/add/:object/:id", :controller => "error_reports", :action => "add", :conditions => { :method => :post }
  map.edit_error_reports "/error_reports/edit/:error_report_id/:object/:id", :controller => "error_reports", :action => "edit", :conditions => { :method => :post }
  map.delete_error_reports "/error_reports/:id/:object_class/:object_id", :controller => "error_reports", :action => "destroy", :conditions => { :method => :delete }
  map.fix_error_reports "/error_reports/fix/:id", :controller => "error_reports", :action => "fix", :conditions => { :method => :post }
  
  map.update_periodical_issues_list "/periodical_issues/refresh_list", :controller => "periodical_issues", :action => "refresh_list"

  map.about '/about', :controller => 'statics', :action => 'show', :id => 'about'
  map.help '/help', :controller => 'statics', :action => 'show', :id => 'help'
  map.legal '/legal', :controller => 'statics', :action => 'show', :id => 'legal'

  # map.general_html ":name/:id.:format", :controller => "general_html", :action => "show", :format => /html/
  # map.general_html_no_ext ":name/:id", :controller => "general_html", :action => "show"

  map.robots '/robots.txt', :controller => 'statics', :action => 'robots'

  
  map.root :controller => 'statics', :action => 'show', :id => 'root'
  
end