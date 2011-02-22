# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101229150504) do

  create_table "alumni", :force => true do |t|
    t.integer  "organisation_id"
    t.integer  "person_id"
    t.string   "start_year"
    t.string   "end_year"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.integer  "old_id"
    t.string   "details"
  end

  add_index "alumni", ["organisation_id"], :name => "index_alumni_on_organisation_id"
  add_index "alumni", ["person_id"], :name => "index_alumni_on_person_id"

  create_table "archive_part_versioned", :force => true do |t|
    t.integer  "archive_part_id"
    t.integer  "version"
    t.string   "title",                :limit => 300
    t.integer  "donation_id"
    t.integer  "warehouse_id"
    t.string   "classification_code"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.string   "permalink"
    t.integer  "views"
    t.datetime "viewed_at"
    t.integer  "old_id"
    t.boolean  "delta",                               :default => true
    t.string   "versioned_class_name",                :default => "ArchivePart"
    t.string   "cached_slug"
  end

  add_index "archive_part_versioned", ["archive_part_id"], :name => "index_archive_part_versioned_on_archive_part_id"

  create_table "archive_parts", :force => true do |t|
    t.string   "title",               :limit => 300
    t.integer  "donation_id"
    t.integer  "warehouse_id"
    t.string   "classification_code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.string   "permalink"
    t.integer  "views"
    t.datetime "viewed_at"
    t.integer  "old_id"
    t.string   "class_name",                         :default => "ArchivePart"
    t.boolean  "delta",                              :default => true,          :null => false
    t.integer  "version"
    t.integer  "lock_version",                       :default => 0
    t.string   "cached_slug"
  end

  add_index "archive_parts", ["class_name"], :name => "index_archive_parts_on_class_name"
  add_index "archive_parts", ["donation_id"], :name => "index_archive_parts_on_donation_id"
  add_index "archive_parts", ["permalink"], :name => "index_archive_parts_on_permalink"

  create_table "article_languages", :force => true do |t|
    t.integer  "article_id"
    t.integer  "language_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.integer  "old_id"
    t.integer  "language_role_id"
  end

  add_index "article_languages", ["article_id"], :name => "index_article_languages_on_article_id"

  create_table "article_versioned", :force => true do |t|
    t.integer  "article_id"
    t.integer  "version"
    t.string   "title",                :limit => 300
    t.integer  "periodical_issue_id"
    t.string   "reference"
    t.boolean  "available"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.string   "permalink"
    t.integer  "views"
    t.datetime "viewed_at"
    t.integer  "old_id"
    t.string   "pages"
    t.boolean  "delta",                               :default => true
    t.string   "versioned_class_name",                :default => "Article"
    t.string   "cached_slug"
  end

  add_index "article_versioned", ["article_id"], :name => "index_article_versioned_on_article_id"

  create_table "articles", :force => true do |t|
    t.string   "title",               :limit => 300
    t.integer  "periodical_issue_id"
    t.string   "reference"
    t.boolean  "available"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.string   "permalink"
    t.integer  "views"
    t.datetime "viewed_at"
    t.integer  "old_id"
    t.string   "class_name",                         :default => "Article"
    t.boolean  "delta",                              :default => true,      :null => false
    t.integer  "version"
    t.integer  "lock_version",                       :default => 0
    t.string   "cached_slug"
  end

  add_index "articles", ["class_name"], :name => "index_articles_on_class_name"
  add_index "articles", ["periodical_issue_id"], :name => "index_articles_on_periodical_copy_id"
  add_index "articles", ["permalink"], :name => "index_articles_on_permalink"

  create_table "audio_video_languages", :force => true do |t|
    t.integer  "audio_video_title_id"
    t.integer  "language_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.integer  "language_role_id"
    t.integer  "old_id"
  end

  add_index "audio_video_languages", ["audio_video_title_id"], :name => "index_audio_video_languages_on_audio_video_title_id"

  create_table "audio_video_media", :force => true do |t|
    t.integer  "audio_video_medium_type_id"
    t.date     "date"
    t.integer  "copy_of_id"
    t.integer  "donation_id"
    t.string   "library_location"
    t.integer  "warehouse_id"
    t.boolean  "available"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.string   "permalink"
    t.integer  "old_id"
    t.string   "barcode"
    t.boolean  "print_barcode"
    t.string   "cached_slug"
    t.integer  "source_id"
  end

  add_index "audio_video_media", ["copy_of_id"], :name => "index_audio_video_media_on_copy_of_id"
  add_index "audio_video_media", ["donation_id"], :name => "index_audio_video_media_on_donation_id"

  create_table "audio_video_medium_types", :force => true do |t|
    t.string   "description_nl"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.integer  "old_id"
    t.string   "description_fr"
    t.string   "description_en"
  end

  create_table "audio_video_title_on_media", :force => true do |t|
    t.integer  "audio_video_title_id"
    t.integer  "audio_video_medium_id"
    t.string   "player_position"
    t.string   "quality"
    t.integer  "source_id"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.integer  "old_id"
  end

  add_index "audio_video_title_on_media", ["audio_video_medium_id"], :name => "index_audio_video_title_on_media_on_audio_video_medium_id"
  add_index "audio_video_title_on_media", ["audio_video_title_id"], :name => "index_audio_video_title_on_media_on_audio_video_title_id"
  add_index "audio_video_title_on_media", ["source_id"], :name => "index_audio_video_title_on_media_on_source_id"

  create_table "audio_video_title_versioned", :force => true do |t|
    t.integer  "audio_video_title_id"
    t.integer  "version"
    t.string   "title"
    t.string   "description_nl",       :limit => 300
    t.string   "creation_date_text"
    t.integer  "duration_minutes"
    t.string   "copyright"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.string   "permalink"
    t.string   "description_fr"
    t.string   "description_en"
    t.integer  "views"
    t.datetime "viewed_at"
    t.integer  "old_id"
    t.integer  "creation_date_id"
    t.boolean  "delta",                               :default => true
    t.string   "versioned_class_name",                :default => "AudioVideoTitle"
    t.string   "cached_slug"
    t.integer  "description_id"
  end

  add_index "audio_video_title_versioned", ["audio_video_title_id"], :name => "index_audio_video_title_versioned_on_audio_video_title_id"

  create_table "audio_video_titles", :force => true do |t|
    t.string   "title"
    t.string   "description_nl",     :limit => 300
    t.string   "creation_date_text"
    t.integer  "duration_minutes"
    t.string   "copyright"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.string   "permalink"
    t.string   "description_fr"
    t.string   "description_en"
    t.integer  "views"
    t.datetime "viewed_at"
    t.integer  "old_id"
    t.integer  "creation_date_id"
    t.string   "class_name",                        :default => "AudioVideoTitle"
    t.boolean  "delta",                             :default => true,              :null => false
    t.integer  "version"
    t.integer  "lock_version",                      :default => 0
    t.string   "cached_slug"
    t.integer  "description_id"
  end

  add_index "audio_video_titles", ["class_name"], :name => "index_audio_video_titles_on_class_name"
  add_index "audio_video_titles", ["permalink"], :name => "index_audio_video_titles_on_permalink"

  create_table "book_copies", :force => true do |t|
    t.integer  "book_title_id"
    t.integer  "donation_id"
    t.string   "library_location"
    t.integer  "warehouse_id"
    t.boolean  "borrowable"
    t.boolean  "available"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.string   "barcode"
    t.string   "permalink"
    t.integer  "views"
    t.datetime "viewed_at"
    t.integer  "old_id"
    t.boolean  "print_barcode"
    t.string   "cached_slug"
  end

  add_index "book_copies", ["book_title_id"], :name => "index_book_copies_on_book_title_id"
  add_index "book_copies", ["donation_id"], :name => "index_book_copies_on_donation_id"

  create_table "book_title_impressums", :force => true do |t|
    t.integer  "book_title_id"
    t.integer  "impressum_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.integer  "old_id"
  end

  add_index "book_title_impressums", ["book_title_id"], :name => "index_book_title_impressums_on_book_title_id"
  add_index "book_title_impressums", ["impressum_id"], :name => "index_book_title_impressums_on_impressum_id"

  create_table "book_title_languages", :force => true do |t|
    t.integer  "book_title_id"
    t.integer  "language_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.integer  "old_id"
    t.integer  "language_role_id"
  end

  add_index "book_title_languages", ["book_title_id"], :name => "index_book_title_languages_on_book_title_id"

  create_table "book_title_versioned", :force => true do |t|
    t.integer  "book_title_id"
    t.integer  "version"
    t.string   "title",                        :limit => 1000
    t.string   "title_extra",                  :limit => 1000
    t.integer  "publication_year"
    t.string   "ean"
    t.integer  "part_of_book_title_id"
    t.string   "collation"
    t.string   "issn"
    t.boolean  "subscription_running"
    t.string   "subscription_type"
    t.date     "subscription_expiration_date"
    t.integer  "number_count"
    t.string   "subscription_note"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.string   "permalink"
    t.integer  "views"
    t.datetime "viewed_at"
    t.integer  "old_id"
    t.integer  "number_of_pages"
    t.boolean  "delta",                                        :default => true
    t.string   "versioned_class_name",                         :default => "BookTitle"
    t.string   "cached_slug"
  end

  add_index "book_title_versioned", ["book_title_id"], :name => "index_book_title_versioned_on_book_title_id"

  create_table "book_titles", :force => true do |t|
    t.string   "title",                        :limit => 1000
    t.string   "title_extra",                  :limit => 1000
    t.integer  "publication_year"
    t.string   "ean"
    t.integer  "part_of_book_title_id"
    t.string   "collation"
    t.string   "issn"
    t.boolean  "subscription_running"
    t.string   "subscription_type"
    t.date     "subscription_expiration_date"
    t.integer  "number_count"
    t.string   "subscription_note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.string   "permalink"
    t.integer  "views"
    t.datetime "viewed_at"
    t.integer  "old_id"
    t.integer  "number_of_pages"
    t.string   "class_name",                                   :default => "BookTitle"
    t.boolean  "delta",                                        :default => true,        :null => false
    t.integer  "version"
    t.integer  "lock_version",                                 :default => 0
    t.string   "cached_slug"
  end

  add_index "book_titles", ["class_name"], :name => "index_book_titles_on_class_name"
  add_index "book_titles", ["part_of_book_title_id"], :name => "index_book_titles_on_part_of_book_title_id"
  add_index "book_titles", ["permalink"], :name => "index_book_titles_on_permalink"

  create_table "box_types", :force => true do |t|
    t.string   "description_nl"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.string   "description_fr"
    t.string   "description_en"
    t.integer  "old_id"
  end

  create_table "cdb_actor_details", :force => true do |t|
    t.integer  "cdb_actor_id"
    t.integer  "language_id"
    t.text     "longdescription"
    t.string   "shortdescription", :limit => 600
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "old_id"
  end

  create_table "cdb_actors", :force => true do |t|
    t.string   "cdbid"
    t.string   "externalid"
    t.boolean  "person"
    t.boolean  "private"
    t.string   "label"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "old_id"
  end

  create_table "cdb_addresses", :force => true do |t|
    t.boolean  "main"
    t.boolean  "reservation"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cdb_location_id"
    t.integer  "old_id"
  end

  create_table "cdb_categories", :force => true do |t|
    t.string   "catid"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "text"
    t.integer  "old_id"
  end

  create_table "cdb_category_cdb_events", :force => true do |t|
    t.integer  "cdb_category_id"
    t.integer  "cdb_event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "old_id"
  end

  create_table "cdb_cities", :force => true do |t|
    t.string   "cdbid"
    t.string   "city"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "old_id"
  end

  create_table "cdb_contactinfos", :force => true do |t|
    t.integer  "cdb_actor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cdb_event_id"
    t.integer  "old_id"
  end

  create_table "cdb_event_details", :force => true do |t|
    t.integer  "cdb_event_id"
    t.integer  "language_id"
    t.string   "admission"
    t.string   "calendarsummary",  :limit => 3500
    t.string   "estimatedtime"
    t.text     "longdescription"
    t.string   "shortdescription", :limit => 600
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "old_id"
  end

  create_table "cdb_events", :force => true do |t|
    t.integer  "cdb_location_id"
    t.string   "cdbid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cdb_organisation_id"
    t.string   "permalink"
    t.string   "title_nl"
    t.integer  "old_id"
    t.string   "cached_slug"
  end

  create_table "cdb_gis", :force => true do |t|
    t.integer  "cdb_physical_address_id"
    t.string   "xcoordinate"
    t.string   "ycoordinate"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "old_id"
  end

  create_table "cdb_locations", :force => true do |t|
    t.integer  "cdb_address_id"
    t.integer  "cdb_actor_id"
    t.integer  "cdb_event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.integer  "old_id"
  end

  create_table "cdb_organisations", :force => true do |t|
    t.string   "label"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cdbid"
    t.string   "permalink"
    t.integer  "old_id"
    t.string   "cached_slug"
  end

  create_table "cdb_parent_events", :force => true do |t|
    t.integer  "cdb_event_id"
    t.string   "cdbid"
    t.string   "externalid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "old_id"
  end

  create_table "cdb_performers", :force => true do |t|
    t.string   "role"
    t.integer  "cdb_actor_id"
    t.string   "label"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cdb_event_detail_id"
    t.integer  "old_id"
  end

  create_table "cdb_physical_addresses", :force => true do |t|
    t.integer  "cdb_address_id"
    t.integer  "cdb_city_id"
    t.integer  "country_id"
    t.string   "housenr"
    t.integer  "cdb_street_id"
    t.string   "zipcode"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cdb_gis_id"
    t.integer  "old_id"
  end

  create_table "cdb_prices", :force => true do |t|
    t.float    "pricevalue"
    t.string   "pricedescription",    :limit => 1000
    t.integer  "cdb_event_detail_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "old_id"
  end

  create_table "cdb_related_productions", :force => true do |t|
    t.integer  "cdb_event_id"
    t.string   "cdbid"
    t.string   "externalid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "old_id"
  end

  create_table "cdb_streets", :force => true do |t|
    t.string   "street"
    t.string   "cdbid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "old_id"
  end

  create_table "cdb_timestamps", :force => true do |t|
    t.integer  "cdb_event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "date"
    t.time     "timestart"
    t.time     "timeend"
    t.integer  "old_id"
  end

  create_table "cdb_urls", :force => true do |t|
    t.integer  "cdb_contactinfo_id"
    t.boolean  "main"
    t.boolean  "reservation"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "old_id"
  end

  create_table "cdb_virtual_addresses", :force => true do |t|
    t.integer  "cdb_address_id"
    t.string   "title",          :limit => 1500
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "old_id"
  end

  create_table "countries", :force => true do |t|
    t.string   "iso_code",    :limit => 2
    t.string   "name_en"
    t.string   "name_nl"
    t.string   "name_fr"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.string   "permalink"
    t.integer  "old_id"
    t.string   "cached_slug"
  end

  add_index "countries", ["permalink"], :name => "index_countries_on_permalink"

  create_table "date_isaars", :force => true do |t|
    t.integer  "day"
    t.integer  "month"
    t.integer  "year"
    t.string   "state"
    t.string   "source"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.integer  "old_id"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "descriptions", :force => true do |t|
    t.string   "description_nl"
    t.string   "description_fr"
    t.string   "description_en"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.string   "cached_slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "document_indices", :force => true do |t|
    t.string   "key"
    t.integer  "document_id"
    t.string   "document_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "document_indices", ["key"], :name => "index_document_indices_on_key"

  create_table "donations", :force => true do |t|
    t.string   "code"
    t.string   "title"
    t.date     "donation_date"
    t.string   "ex_dono"
    t.integer  "person_id"
    t.integer  "organisation_id"
    t.integer  "donor_person_id"
    t.integer  "donor_organisation_id"
    t.string   "size"
    t.string   "content",               :limit => 3000
    t.string   "date_info"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.string   "permalink"
    t.integer  "old_id"
    t.string   "cached_slug"
  end

  add_index "donations", ["donor_organisation_id"], :name => "index_donations_on_donor_organisation_id"
  add_index "donations", ["donor_person_id"], :name => "index_donations_on_donor_person_id"
  add_index "donations", ["organisation_id"], :name => "index_donations_on_organisation_id"

  create_table "ephemera", :force => true do |t|
    t.integer  "ephemerum_type_id"
    t.string   "title",             :limit => 300
    t.integer  "source_id"
    t.integer  "donation_id"
    t.integer  "warehouse_id"
    t.date     "date"
    t.string   "library_location"
    t.boolean  "available"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.integer  "season_id"
    t.string   "permalink"
    t.integer  "views"
    t.datetime "viewed_at"
    t.integer  "old_id"
    t.string   "class_name",                       :default => "Ephemerum"
    t.boolean  "delta",                            :default => true,        :null => false
    t.integer  "version"
    t.integer  "lock_version",                     :default => 0
    t.string   "cached_slug"
  end

  add_index "ephemera", ["class_name"], :name => "index_ephemera_on_class_name"
  add_index "ephemera", ["donation_id"], :name => "index_ephemera_on_donation_id"
  add_index "ephemera", ["permalink"], :name => "index_ephemera_on_permalink"
  add_index "ephemera", ["source_id"], :name => "index_ephemera_on_source_id"

  create_table "ephemerum_languages", :force => true do |t|
    t.integer  "ephemerum_id"
    t.integer  "language_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.integer  "old_id"
  end

  add_index "ephemerum_languages", ["ephemerum_id"], :name => "index_ephemerum_languages_on_ephemerum_id"

  create_table "ephemerum_types", :force => true do |t|
    t.string   "name"
    t.string   "description_nl"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.string   "description_fr"
    t.string   "description_en"
    t.integer  "old_id"
  end

  create_table "ephemerum_versioned", :force => true do |t|
    t.integer  "ephemerum_id"
    t.integer  "version"
    t.integer  "ephemerum_type_id"
    t.string   "title",                :limit => 300
    t.integer  "source_id"
    t.integer  "donation_id"
    t.integer  "warehouse_id"
    t.date     "date"
    t.string   "library_location"
    t.boolean  "available"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.integer  "season_id"
    t.string   "permalink"
    t.integer  "views"
    t.datetime "viewed_at"
    t.integer  "old_id"
    t.boolean  "delta",                               :default => true
    t.string   "versioned_class_name",                :default => "Ephemerum"
    t.string   "cached_slug"
  end

  add_index "ephemerum_versioned", ["ephemerum_id"], :name => "index_ephemerum_versioned_on_ephemerum_id"

  create_table "error_reports", :force => true do |t|
    t.integer  "error_reportable_id"
    t.string   "error_reportable_type"
    t.string   "message",               :limit => 2500
    t.boolean  "fixed",                                 :default => false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "festivals", :force => true do |t|
    t.integer  "organisation_id"
    t.string   "periodicity"
    t.date     "start"
    t.string   "start_text"
    t.date     "stop"
    t.string   "stop_text"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.integer  "old_id"
    t.string   "permalink"
    t.string   "cached_slug"
  end

  add_index "festivals", ["organisation_id"], :name => "index_festivals_on_organisation_id"

  create_table "functions", :force => true do |t|
    t.string   "name_nl"
    t.string   "type"
    t.string   "marc"
    t.string   "marc_code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.string   "hierarchy"
    t.integer  "old_id"
    t.string   "name_fr"
    t.string   "name_en"
  end

  create_table "genders", :force => true do |t|
    t.string  "code",        :limit => 1
    t.integer "creator_id"
    t.integer "updater_id"
    t.string  "permalink"
    t.string  "name_nl"
    t.string  "name_fr"
    t.string  "name_en"
    t.integer "old_id"
    t.string  "cached_slug"
  end

  add_index "genders", ["permalink"], :name => "index_genders_on_permalink"

  create_table "genres", :force => true do |t|
    t.string   "name_nl"
    t.string   "grouping_term"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.string   "permalink"
    t.integer  "old_id"
    t.boolean  "cluster_danse"
    t.boolean  "cluster_theatre"
    t.boolean  "cluster_musictheatre"
    t.boolean  "cluster_child_youth"
    t.boolean  "cluster_other_disc"
    t.boolean  "cluster_figure_object"
    t.string   "name_fr"
    t.string   "name_en"
    t.string   "search_alternatives"
    t.string   "cached_slug"
  end

  add_index "genres", ["permalink"], :name => "index_production_genres_on_permalink"

  create_table "grant_genres", :force => true do |t|
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.string   "permalink"
    t.integer  "old_id"
    t.string   "cached_slug"
  end

  add_index "grant_genres", ["permalink"], :name => "index_grant_genres_on_permalink"

  create_table "grant_states", :force => true do |t|
    t.string   "description_nl"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.integer  "old_id"
    t.string   "description_fr"
    t.string   "description_en"
  end

  create_table "grant_systems", :force => true do |t|
    t.string   "code"
    t.string   "description"
    t.string   "legal_base"
    t.string   "type"
    t.integer  "grant_genre_id"
    t.string   "organisation_form"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.string   "permalink"
    t.integer  "old_id"
    t.string   "cached_slug"
  end

  add_index "grant_systems", ["permalink"], :name => "index_grant_systems_on_permalink"

  create_table "grants", :force => true do |t|
    t.integer  "grant_state_id"
    t.integer  "grant_system_id"
    t.integer  "person_id"
    t.integer  "organisation_id"
    t.string   "period"
    t.integer  "production_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.integer  "old_id"
    t.string   "permalink"
    t.string   "cached_slug"
  end

  add_index "grants", ["organisation_id"], :name => "index_grants_on_organisation_id"
  add_index "grants", ["person_id"], :name => "index_grants_on_person_id"
  add_index "grants", ["production_id"], :name => "index_grants_on_production_id"

  create_table "ico_title_versioned", :force => true do |t|
    t.integer  "ico_title_id"
    t.integer  "version"
    t.integer  "ico_type_id"
    t.string   "title"
    t.string   "description_nl"
    t.date     "date"
    t.integer  "part_of_ico_title_id"
    t.string   "copyright"
    t.integer  "donation_id"
    t.integer  "archive_part_id"
    t.integer  "number_of_objects"
    t.string   "library_location"
    t.boolean  "available"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.integer  "season_id"
    t.string   "permalink"
    t.string   "description_fr"
    t.string   "description_en"
    t.integer  "views"
    t.datetime "viewed_at"
    t.integer  "old_id"
    t.boolean  "delta",                :default => true
    t.string   "versioned_class_name", :default => "IcoTitle"
    t.string   "cached_slug"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

  add_index "ico_title_versioned", ["ico_title_id"], :name => "index_ico_title_versioned_on_ico_title_id"

  create_table "ico_titles", :force => true do |t|
    t.integer  "ico_type_id"
    t.string   "title"
    t.string   "description_nl"
    t.date     "date"
    t.integer  "part_of_ico_title_id"
    t.string   "copyright"
    t.integer  "donation_id"
    t.integer  "archive_part_id"
    t.integer  "number_of_objects"
    t.string   "library_location"
    t.boolean  "available"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.integer  "season_id"
    t.string   "permalink"
    t.string   "description_fr"
    t.string   "description_en"
    t.integer  "views"
    t.datetime "viewed_at"
    t.integer  "old_id"
    t.string   "class_name",           :default => "IcoTitle"
    t.boolean  "delta",                :default => true,       :null => false
    t.integer  "version"
    t.integer  "lock_version",         :default => 0
    t.string   "cached_slug"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

  add_index "ico_titles", ["archive_part_id"], :name => "index_ico_titles_on_archive_part_id"
  add_index "ico_titles", ["class_name"], :name => "index_ico_titles_on_class_name"
  add_index "ico_titles", ["donation_id"], :name => "index_ico_titles_on_donation_id"
  add_index "ico_titles", ["part_of_ico_title_id"], :name => "index_ico_titles_on_part_of_ico_title_id"
  add_index "ico_titles", ["permalink"], :name => "index_ico_titles_on_permalink"

  create_table "ico_types", :force => true do |t|
    t.string   "description_nl"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.string   "permalink"
    t.string   "description_fr"
    t.string   "description_en"
    t.integer  "old_id"
    t.string   "cached_slug"
  end

  add_index "ico_types", ["permalink"], :name => "index_ico_types_on_permalink"

  create_table "impressums", :force => true do |t|
    t.string   "publisher"
    t.string   "publish_location"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.string   "permalink"
    t.integer  "old_id"
    t.string   "code"
    t.string   "cached_slug"
  end

  add_index "impressums", ["permalink"], :name => "index_impressums_on_permalink"

  create_table "language_roles", :force => true do |t|
    t.string   "description_nl"
    t.string   "description_en"
    t.string   "description_fr"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.integer  "old_id"
  end

  create_table "languages", :force => true do |t|
    t.string   "iso_code",    :limit => 3
    t.string   "name_en"
    t.string   "name_nl"
    t.string   "name_fr"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.string   "permalink"
    t.integer  "old_id"
    t.string   "cached_slug"
  end

  add_index "languages", ["permalink"], :name => "index_languages_on_permalink"

  create_table "legal_forms", :force => true do |t|
    t.string   "name_nl"
    t.string   "name_fr"
    t.string   "name_en"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "old_id"
  end

  create_table "missing_translations", :force => true do |t|
    t.string   "key"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "old_id"
  end

  create_table "navigation_letters", :force => true do |t|
    t.string  "classname"
    t.string  "letters",   :limit => 10000
    t.integer "old_id"
  end

  create_table "open_id_authentication_associations", :force => true do |t|
    t.integer "issued"
    t.integer "lifetime"
    t.string  "handle"
    t.string  "assoc_type"
    t.binary  "server_url"
    t.binary  "secret"
  end

  create_table "open_id_authentication_nonces", :force => true do |t|
    t.integer "timestamp",  :null => false
    t.string  "server_url"
    t.string  "salt",       :null => false
  end

  create_table "orders", :force => true do |t|
    t.integer  "organisation_id"
    t.date     "date"
    t.string   "type"
    t.boolean  "sent"
    t.string   "order_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.string   "permalink"
    t.integer  "old_id"
    t.string   "cached_slug"
  end

  add_index "orders", ["organisation_id"], :name => "index_orders_on_organisation_id"
  add_index "orders", ["permalink"], :name => "index_orders_on_permalink"

  create_table "organisation_impressums", :force => true do |t|
    t.integer  "organisation_id"
    t.integer  "impressum_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  add_index "organisation_impressums", ["organisation_id"], :name => "index_organisation_impressums_on_organisation_id"

  create_table "organisation_relation_types", :force => true do |t|
    t.string   "from_name_nl"
    t.string   "to_name_nl"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.string   "from_name_fr"
    t.string   "to_name_fr"
    t.string   "from_name_en"
    t.string   "to_name_en"
    t.integer  "old_id"
  end

  create_table "organisation_relations", :force => true do |t|
    t.integer  "from_id"
    t.integer  "to_id"
    t.integer  "organisation_relation_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.integer  "creation_date_id"
    t.integer  "cancellation_date_id"
    t.integer  "start_activities_date_id"
    t.integer  "end_activities_date_id"
    t.integer  "old_id"
  end

  add_index "organisation_relations", ["from_id"], :name => "index_organisation_relations_on_from_id"
  add_index "organisation_relations", ["to_id"], :name => "index_organisation_relations_on_to_id"

  create_table "organisation_versions", :force => true do |t|
    t.integer  "organisation_id"
    t.integer  "version"
    t.string   "name"
    t.integer  "legal_form_id"
    t.integer  "grant_status_id"
    t.integer  "organisation_type_id"
    t.integer  "language_id"
    t.string   "url"
    t.integer  "publicid"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.integer  "classification_code"
    t.integer  "creation_date_id"
    t.integer  "cancellation_date_id"
    t.integer  "start_activities_date_id"
    t.integer  "end_activities_date_id"
    t.integer  "country_id"
    t.string   "city"
    t.string   "permalink"
    t.integer  "views"
    t.datetime "viewed_at"
    t.integer  "old_id"
    t.string   "cached_slug"
    t.string   "sorted_name"
  end

  add_index "organisation_versions", ["organisation_id"], :name => "index_organisation_versions_on_organisation_id"

  create_table "organisations", :force => true do |t|
    t.string   "name"
    t.integer  "language_id"
    t.string   "url"
    t.integer  "publicid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "version"
    t.integer  "lock_version",             :default => 0
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.integer  "classification_code"
    t.integer  "creation_date_id"
    t.integer  "cancellation_date_id"
    t.integer  "start_activities_date_id"
    t.integer  "end_activities_date_id"
    t.integer  "country_id"
    t.string   "city"
    t.string   "permalink"
    t.integer  "views"
    t.datetime "viewed_at"
    t.integer  "old_id"
    t.integer  "legal_form_id"
    t.string   "cached_slug"
    t.string   "sorted_name"
  end

  add_index "organisations", ["permalink"], :name => "index_organisations_on_permalink"

  create_table "people", :force => true do |t|
    t.string   "last_name"
    t.string   "first_name"
    t.integer  "language_id"
    t.integer  "publicid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "gender_id"
    t.integer  "version"
    t.integer  "lock_version",  :default => 0
    t.string   "permalink"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.integer  "birthdate_id"
    t.integer  "death_date_id"
    t.integer  "country_id"
    t.string   "city"
    t.string   "name"
    t.integer  "views"
    t.datetime "viewed_at"
    t.integer  "old_id"
    t.string   "key_name"
    t.integer  "alias_of_id"
    t.string   "cached_slug"
  end

  add_index "people", ["permalink"], :name => "index_people_on_permalink"

  create_table "periodical_impressums", :force => true do |t|
    t.integer  "impressum_id"
    t.integer  "periodical_id"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "old_id"
  end

  add_index "periodical_impressums", ["periodical_id"], :name => "index_periodical_impressums_on_periodical_id"

  create_table "periodical_issues", :force => true do |t|
    t.string   "title"
    t.integer  "periodical_id"
    t.string   "volume"
    t.string   "number"
    t.string   "date_text"
    t.date     "search_date"
    t.string   "library_location"
    t.integer  "warehouse_id"
    t.boolean  "available"
    t.integer  "donation_id"
    t.integer  "part_of_issue_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.string   "permalink"
    t.string   "barcode"
    t.integer  "old_id"
    t.boolean  "print_barcode"
    t.string   "cached_slug"
  end

  add_index "periodical_issues", ["donation_id"], :name => "index_periodical_copies_on_donation_id"
  add_index "periodical_issues", ["part_of_issue_id"], :name => "index_periodical_copies_on_part_of_copy_id"
  add_index "periodical_issues", ["periodical_id"], :name => "index_periodical_copies_on_periodical_id"
  add_index "periodical_issues", ["permalink"], :name => "index_periodical_copies_on_permalink"

  create_table "periodical_languages", :force => true do |t|
    t.integer  "periodical_id"
    t.integer  "language_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.integer  "old_id"
    t.integer  "language_role_id"
  end

  create_table "periodicals", :force => true do |t|
    t.string   "antilope_index"
    t.string   "title"
    t.string   "title_extra",              :limit => 500
    t.string   "url",                      :limit => 1000
    t.string   "issn"
    t.string   "holdings"
    t.string   "subscription_type"
    t.string   "subscription_periodicity"
    t.boolean  "subscription_running"
    t.date     "subscription_end_date"
    t.string   "subscription_note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.string   "permalink"
    t.integer  "views"
    t.datetime "viewed_at"
    t.integer  "old_id"
    t.string   "cached_slug"
  end

  add_index "periodicals", ["permalink"], :name => "index_periodicals_on_permalink"

  create_table "person_versions", :force => true do |t|
    t.integer  "person_id"
    t.integer  "version"
    t.string   "last_name"
    t.string   "first_name"
    t.integer  "language_id"
    t.integer  "publicid"
    t.datetime "updated_at"
    t.integer  "gender_id"
    t.string   "permalink"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.integer  "birthdate_id"
    t.integer  "death_date_id"
    t.integer  "country_id"
    t.string   "city"
    t.string   "name"
    t.integer  "views"
    t.datetime "viewed_at"
    t.integer  "old_id"
    t.string   "key_name"
    t.integer  "alias_of_id"
    t.string   "cached_slug"
  end

  add_index "person_versions", ["person_id"], :name => "index_person_versions_on_person_id"

  create_table "postits", :force => true do |t|
    t.string   "text",            :limit => 5000
    t.integer  "user_id"
    t.integer  "language_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.integer  "postitable_id"
    t.string   "postitable_type"
    t.integer  "old_id"
  end

  create_table "press_cutting_languages", :force => true do |t|
    t.integer  "press_cutting_id"
    t.integer  "language_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.integer  "old_id"
    t.integer  "language_role_id"
  end

  add_index "press_cutting_languages", ["old_id"], :name => "index_press_cutting_languages_on_old_id"
  add_index "press_cutting_languages", ["press_cutting_id"], :name => "index_press_cutting_languages_on_press_cutting_id"

  create_table "press_cutting_versioned", :force => true do |t|
    t.integer  "press_cutting_id"
    t.integer  "version"
    t.string   "title",                :limit => 300
    t.date     "date"
    t.integer  "periodical_id"
    t.string   "library_location"
    t.boolean  "available",                           :default => false
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.string   "permalink"
    t.integer  "old_id"
    t.integer  "views"
    t.datetime "viewed_at"
    t.boolean  "delta",                               :default => true
    t.string   "versioned_class_name",                :default => "PressCutting"
    t.string   "cached_slug"
  end

  add_index "press_cutting_versioned", ["press_cutting_id"], :name => "index_press_cutting_versioned_on_press_cutting_id"

  create_table "press_cuttings", :force => true do |t|
    t.string   "title",            :limit => 300
    t.date     "date"
    t.integer  "periodical_id"
    t.string   "library_location"
    t.boolean  "available",                       :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.string   "permalink"
    t.integer  "old_id"
    t.integer  "views"
    t.datetime "viewed_at"
    t.string   "class_name",                      :default => "PressCutting"
    t.boolean  "delta",                           :default => true,           :null => false
    t.integer  "version"
    t.integer  "lock_version",                    :default => 0
    t.string   "cached_slug"
  end

  add_index "press_cuttings", ["class_name"], :name => "index_press_cuttings_on_class_name"
  add_index "press_cuttings", ["old_id"], :name => "index_press_cuttings_on_old_id"
  add_index "press_cuttings", ["periodical_id"], :name => "index_press_cuttings_on_periodical_id"
  add_index "press_cuttings", ["permalink"], :name => "index_press_cuttings_on_permalink"

  create_table "production_languages", :force => true do |t|
    t.integer  "production_id"
    t.integer  "language_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.integer  "old_id"
    t.integer  "language_role_id"
  end

  add_index "production_languages", ["production_id"], :name => "index_production_languages_on_production_id"

  create_table "production_versions", :force => true do |t|
    t.integer  "production_id"
    t.integer  "version"
    t.string   "title"
    t.string   "inspiration"
    t.string   "target_audience_text_nl"
    t.integer  "target_audience_from"
    t.integer  "target_audience_to"
    t.integer  "rerun_of_id"
    t.boolean  "verified"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.integer  "season_id"
    t.string   "permalink"
    t.integer  "views"
    t.datetime "viewed_at"
    t.string   "target_audience_text_fr"
    t.string   "target_audience_text_en"
    t.integer  "old_id"
    t.text     "description_nl"
    t.text     "description_fr"
    t.text     "description_en"
    t.string   "external_id"
    t.string   "number_by_country"
    t.string   "library_location"
    t.boolean  "visible",                 :default => false
    t.string   "cached_slug"
  end

  add_index "production_versions", ["production_id"], :name => "index_production_versions_on_production_id"

  create_table "productions", :force => true do |t|
    t.string   "title"
    t.string   "inspiration"
    t.string   "target_audience_text_nl"
    t.integer  "target_audience_from"
    t.integer  "target_audience_to"
    t.integer  "rerun_of_id"
    t.boolean  "verified"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.integer  "season_id"
    t.string   "permalink"
    t.integer  "views"
    t.datetime "viewed_at"
    t.string   "target_audience_text_fr"
    t.string   "target_audience_text_en"
    t.integer  "version"
    t.integer  "lock_version",            :default => 0
    t.integer  "old_id"
    t.text     "description_nl"
    t.text     "description_fr"
    t.text     "description_en"
    t.string   "external_id"
    t.string   "number_by_country"
    t.string   "library_location"
    t.boolean  "visible",                 :default => false
    t.string   "cached_slug"
  end

  add_index "productions", ["permalink"], :name => "index_productions_on_permalink"
  add_index "productions", ["rerun_of_id"], :name => "index_productions_on_revival_of_id"

  create_table "relationships", :force => true do |t|
    t.integer  "audio_video_title_id"
    t.integer  "organisation_id"
    t.integer  "person_id"
    t.integer  "production_id"
    t.integer  "archive_part_id"
    t.string   "function_text"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.integer  "article_id"
    t.integer  "function_id"
    t.integer  "book_title_id"
    t.integer  "index"
    t.integer  "ephemerum_id"
    t.integer  "ico_title_id"
    t.integer  "genre_id"
    t.string   "role_info"
    t.string   "reference_type"
    t.integer  "venue_id"
    t.integer  "language_id"
    t.integer  "order_id"
    t.string   "language_note"
    t.datetime "delivery_date"
    t.integer  "old_id"
    t.integer  "press_cutting_id"
    t.integer  "warehouse_id"
    t.boolean  "visible",                       :default => true
    t.integer  "donation_id"
    t.integer  "periodical_id"
    t.integer  "organisation_from_id"
    t.integer  "organisation_to_id"
    t.integer  "organisation_relation_type_id"
    t.integer  "creation_date_id"
    t.integer  "cancellation_date_id"
    t.integer  "start_activities_date_id"
    t.integer  "end_activities_date_id"
    t.integer  "language_role_id"
  end

  add_index "relationships", ["archive_part_id"], :name => "index_relationships_on_archive_part_id"
  add_index "relationships", ["article_id"], :name => "index_relationships_on_article_id"
  add_index "relationships", ["audio_video_title_id"], :name => "index_relationships_on_audio_video_title_id"
  add_index "relationships", ["book_title_id"], :name => "index_relationships_on_book_title_id"
  add_index "relationships", ["ephemerum_id"], :name => "index_relationships_on_ephemerum_id"
  add_index "relationships", ["function_id"], :name => "index_relationships_on_function_id"
  add_index "relationships", ["genre_id"], :name => "index_relationships_on_production_genre_id"
  add_index "relationships", ["ico_title_id"], :name => "index_relationships_on_ico_title_id"
  add_index "relationships", ["language_id"], :name => "index_relationships_on_language_id"
  add_index "relationships", ["order_id"], :name => "index_relationships_on_order_id"
  add_index "relationships", ["organisation_id"], :name => "index_relationships_on_organisation_id"
  add_index "relationships", ["person_id"], :name => "index_relationships_on_person_id"
  add_index "relationships", ["production_id"], :name => "index_relationships_on_production_id"
  add_index "relationships", ["type"], :name => "index_relationships_on_type"
  add_index "relationships", ["venue_id"], :name => "index_relationships_on_room_id"

  create_table "seasons", :force => true do |t|
    t.integer  "start_year"
    t.integer  "end_year"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.string   "permalink"
    t.boolean  "visible",     :default => false
    t.integer  "old_id"
    t.string   "cached_slug"
  end

  add_index "seasons", ["permalink"], :name => "index_seasons_on_permalink"

  create_table "show_types", :force => true do |t|
    t.string   "name_nl"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.string   "permalink"
    t.string   "name_fr"
    t.string   "name_en"
    t.integer  "old_id"
    t.string   "cached_slug"
  end

  add_index "show_types", ["permalink"], :name => "index_show_types_on_permalink"

  create_table "shows", :force => true do |t|
    t.integer  "production_id"
    t.integer  "show_type_id"
    t.integer  "venue_id"
    t.integer  "organisation_id"
    t.string   "time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.integer  "old_id"
    t.boolean  "visible",         :default => false
    t.string   "permalink"
    t.integer  "date_id"
  end

  add_index "shows", ["organisation_id"], :name => "index_shows_on_organisation_id"
  add_index "shows", ["production_id"], :name => "index_shows_on_production_id"
  add_index "shows", ["venue_id"], :name => "index_shows_on_room_id"

  create_table "slugs", :force => true do |t|
    t.string   "name"
    t.integer  "sluggable_id"
    t.integer  "sequence",                     :default => 1, :null => false
    t.string   "sluggable_type", :limit => 40
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "slugs", ["name", "sluggable_type", "sequence", "scope"], :name => "index_slugs_on_n_s_s_and_s", :unique => true
  add_index "slugs", ["sluggable_id"], :name => "index_slugs_on_sluggable_id"

  create_table "statics", :force => true do |t|
    t.string   "name"
    t.text     "text_nl"
    t.text     "text_en"
    t.text     "text_fr"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.integer  "old_id"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.datetime "created_at"
    t.integer  "old_id"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type"], :name => "index_taggings_on_taggable_id_and_taggable_type"

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.string   "permalink"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "old_id"
    t.integer  "language_id"
    t.string   "cached_slug"
  end

  create_table "users", :force => true do |t|
    t.string   "login",        :limit => 40
    t.string   "name",         :limit => 100, :default => ""
    t.string   "email",        :limit => 100
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "identity_url"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.string   "permalink"
    t.boolean  "admin",                       :default => false
    t.integer  "language_id"
    t.integer  "old_id"
    t.string   "cached_slug"
  end

  add_index "users", ["permalink"], :name => "index_users_on_permalink"

  create_table "venues", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "postal_code"
    t.string   "city"
    t.integer  "country_id"
    t.boolean  "temporary_location"
    t.boolean  "address_manager"
    t.string   "phone"
    t.string   "fax"
    t.string   "default_start_hour"
    t.string   "email"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.string   "permalink"
    t.integer  "old_id"
    t.string   "cached_slug"
  end

  add_index "venues", ["permalink"], :name => "index_rooms_on_permalink"

  create_table "warehouses", :force => true do |t|
    t.integer  "box_type_id"
    t.string   "box_location"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.string   "permalink"
    t.string   "barcode"
    t.integer  "views"
    t.datetime "viewed_at"
    t.integer  "old_id"
    t.boolean  "print_barcode"
    t.string   "cached_slug"
  end

  add_index "warehouses", ["permalink"], :name => "index_warehouses_on_permalink"

end
