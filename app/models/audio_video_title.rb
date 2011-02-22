class AudioVideoTitle < Document
  set_table_name "audio_video_titles"
  acts_as_versioned :table_name => "audio_video_title_versioned", :association_options => { :dependent => :nullify }
  acts_as_taggable
  
  set_friendly_id :title

  field_sequence [ :title, :duration_minutes, :audio_video_media, :library_location, :warehouse, :description_id ]
  hidden_fields  [ :description_nl, :description_fr, :description_en ]
  relations      [ :author_relations, :subject_relations ]

  stampable
  
  belongs_to :creation_date, :class_name => "DateIsaar"
  belongs_to :description
  
  has_many :by_people, :through => :audio_video_title_by_people, :source => :person
  has_many :audio_video_title_by_people, :dependent => :destroy

  has_many :about_people, :through => :audio_video_title_about_people, :source => :person
  has_many :audio_video_title_about_people, :dependent => :destroy
  
  has_many :by_organisations, :through => :audio_video_title_by_organisations, :source => :organisation
  has_many :audio_video_title_by_organisations, :dependent => :destroy
    
  has_many :about_organisations, :through => :audio_video_title_about_organisations, :source => :organisation
  has_many :audio_video_title_about_organisations  , :dependent => :destroy
  
  has_many :about_productions, :through => :audio_video_title_about_productions, :source => :production
  has_many :audio_video_title_about_productions, :dependent => :destroy

  has_many :audio_video_title_on_media, :dependent => :nullify
  has_many :audio_video_media, :through => :audio_video_title_on_media 

  has_many :about_genres, :through => :audio_video_title_about_genres, :source => :genre
  has_many :audio_video_title_about_genres
  
  has_many :audio_video_languages, :dependent => :nullify
  has_many :languages, :through => :audio_video_languages
  has_many :language_role, :through => :audio_video_languages
   
  define_index do
    indexes title
    indexes tags(:name),                                                      :as => :tag
    indexes audio_video_title_by_people.person(:first_name),                  :as => :author_first_name
    indexes audio_video_title_by_people.person(:last_name),                   :as => :author_last_name
    indexes audio_video_title_by_organisations.organisation(:name),           :as => :author_name
    indexes audio_video_title_about_people.person(:first_name),               :as => :subject_first_name
    indexes audio_video_title_about_people.person(:last_name),                :as => :subject_last_name
    indexes audio_video_title_about_organisations.organisation(:name),        :as => :subject_name
    indexes audio_video_title_about_productions.production(:title),           :as => :production_title
    indexes audio_video_title_about_genres.genre(:name_nl),                   :as => :genre_name_nl
    indexes audio_video_title_about_genres.genre(:name_fr),                   :as => :genre_name_fr
    indexes audio_video_title_about_genres.genre(:name_en),                   :as => :genre_name_en
    # indexes audio_video_title_on_media.audio_video_medium(:barcode),          :as => :barcode
    
    set_property :delta => :delayed
  end

  def appearance_date
    creation_date
  end

  def library_location
    audio_video_media.collect{|avm| avm.library_location}.join(', ')  
  end

  def warehouse
    audio_video_media.collect{|avm| avm.warehouse}.join(', ')  
  end

  def self.base_class
    AudioVideoTitle
  end

end
