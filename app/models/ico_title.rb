class IcoTitle < Document
  set_table_name "ico_titles"
  acts_as_versioned :table_name => "ico_title_versioned", :association_options => { :dependent => :nullify }
  
  has_attached_file :picture, :styles => { :medium => "250x250>", :small => "100x100>" }
  
  set_friendly_id :title
  
  acts_as_taggable

  relations [:author_relations, :subject_relations]
  
  hidden_fields [:picture_content_type, :picture_file_size, :picture_updated_at]
  
  belongs_to :donation

  belongs_to :part_of_ico_title, :class_name => 'IcoTitle'
  belongs_to :ico_type
  belongs_to :archive_part
  belongs_to :season
  stampable
  
  has_many :by_people, :through => :ico_title_by_people, :source => :person
  has_many :ico_title_by_people, :include => :person
  
  has_many :about_people, :through => :ico_title_about_people, :source => :person
  has_many :ico_title_about_people, :include => :person
  
  has_many :by_organisations, :through => :ico_title_by_organisations, :source => :organisation
  has_many :ico_title_by_organisations, :include => :organisation
  
  has_many :about_organisations, :through => :ico_title_about_organisations, :source => :organisation
  has_many :ico_title_about_organisations, :include => :organisation
  
  has_many :about_productions, :through => :ico_title_about_productions, :source => :production
  has_many :ico_title_about_productions, :include => :production

  has_many :about_genres, :through => :ico_title_about_genres, :source => :genre
  has_many :ico_title_about_genres
  
  define_index do
    indexes title
    indexes tags(:name),                                       :as => :tag
    indexes ico_title_by_people.person(:first_name),           :as => :author_first_name
    indexes ico_title_by_people.person(:last_name),            :as => :author_last_name
    indexes ico_title_by_organisations.organisation(:name),    :as => :author_name
    indexes ico_title_about_people.person(:first_name),        :as => :subject_first_name
    indexes ico_title_about_people.person(:last_name),         :as => :subject_last_name
    indexes ico_title_about_organisations.organisation(:name), :as => :subject_name
    indexes ico_title_about_productions.production(:title),    :as => :production_title
    indexes ico_title_about_genres.genre(:name_nl),            :as => :genre_name_nl
    indexes ico_title_about_genres.genre(:name_fr),            :as => :genre_name_fr
    indexes ico_title_about_genres.genre(:name_en),            :as => :genre_name_en
    
    set_property :delta => :delayed
  end

  def creation_date 
    self.date
  end

  def appearance_date
    date
  end

  def self.base_class
    IcoTitle
  end

  
end
