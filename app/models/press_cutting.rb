class PressCutting < Document
  set_table_name "press_cuttings"
  acts_as_versioned :table_name => "press_cutting_versioned", :association_options => { :dependent => :nullify }
  
  acts_as_taggable
  
  validates_presence_of :title
  validates_length_of :title, :maximum=>300

  field_sequence [:title, :periodical_id]
  relations [:press_cutting_languages, :author_relations, :subject_relations]
  hidden_relations [:press_cutting_about_genres]

  set_friendly_id :title

  belongs_to :periodical
  stampable
  
  has_many :by_people, :through => :press_cutting_by_people, :source => :person
  has_many :press_cutting_by_people, :include => :person, :dependent => :destroy
  
  has_many :about_people, :through => :press_cutting_about_people, :source => :person
  has_many :press_cutting_about_people, :include => :person, :dependent => :destroy
  
  has_many :by_organisations, :through => :press_cutting_by_organisations, :source => :organisation
  has_many :press_cutting_by_organisations, :include => :organisation, :dependent => :destroy
  
  has_many :about_organisations, :through => :press_cutting_about_organisations, :source => :organisation
  has_many :press_cutting_about_organisations, :include => :organisation, :dependent => :destroy
  
  has_many :about_productions, :through => :press_cutting_about_productions, :source => :production
  has_many :press_cutting_about_productions, :include => :production, :dependent => :destroy

  has_many :about_genres, :through => :press_cutting_about_genres, :source => :genre
  has_many :press_cutting_about_genres
  
  has_many :press_cutting_languages

  before_save :layout_library_location
  
  define_index do
    indexes title
    indexes tags(:name),                                           :as => :tag
    indexes press_cutting_by_people.person(:first_name),           :as => :author_first_name
    indexes press_cutting_by_people.person(:last_name),            :as => :author_last_name
    indexes press_cutting_by_organisations.organisation(:name),    :as => :author_name
    indexes press_cutting_about_people.person(:first_name),        :as => :subject_first_name
    indexes press_cutting_about_people.person(:last_name),         :as => :subject_last_name
    indexes press_cutting_about_organisations.organisation(:name), :as => :subject_name
    indexes press_cutting_about_productions.production(:title),    :as => :production_title
    indexes press_cutting_about_genres.genre(:name_nl),            :as => :genre_name_nl
    indexes press_cutting_about_genres.genre(:name_fr),            :as => :genre_name_fr
    indexes press_cutting_about_genres.genre(:name_en),            :as => :genre_name_en
    
    set_property :delta => :delayed
  end
  
  def creation_date 
    self.date
  end

  def appearance_date
    self.date
  end

  def self.base_class
    PressCutting
  end
  
  def self.relations_in_sequence
    [:press_cutting_languages, :periodical, :press_cutting_by_people, :press_cutting_about_productions, :press_cutting_about_people,
      :press_cutting_about_organisations]
  end
  
  def layout_library_location
    if library_location.present?
      self.library_location = self.library_location.upcase.gsub(/\s/, '')
    end
  end

end
