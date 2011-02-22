class Ephemerum < Document

  include DeltaFlag

  set_table_name "ephemera"
  acts_as_versioned :table_name => "ephemerum_versioned", :association_options => { :dependent => :nullify }

  acts_as_taggable

  named_scope :season, :joins => :visible, :conditions => ['season.visible = ?', true]

  relations [:author_relations, :subject_relations, :ephemerum_languages]

  set_friendly_id :title

  stampable
  belongs_to :ephemerum_type
  belongs_to :source, :class_name => 'Organisation'
  belongs_to :donation
  belongs_to :warehouse
  belongs_to :season

  has_many :by_people, :through => :ephemerum_by_people, :source => :person
  has_many :ephemerum_by_people, :dependent => :destroy

  has_many :about_people, :through => :ephemerum_about_people, :source => :person
  has_many :ephemerum_about_people, :dependent => :destroy

  has_many :by_organisations, :through => :ephemerum_by_organisations, :source => :organisation
  has_many :ephemerum_by_organisations, :dependent => :destroy

  has_many :about_organisations, :through => :ephemerum_about_organisations, :source => :organisation
  has_many :ephemerum_about_organisations, :dependent => :destroy

  has_many :about_productions, :through => :ephemerum_about_productions, :source => :production
  has_many :ephemerum_about_productions, :dependent => :destroy

  has_many :about_genres, :through => :ephemerum_about_genres, :source => :genre
  has_many :ephemerum_about_genres

  has_many :ephemerum_languages
  has_many :languages, :through => :ephemerum_languages

  define_index do
    indexes title
    indexes tags(:name),                                       :as => :tag
    indexes ephemerum_by_people.person(:first_name),           :as => :author_first_name
    indexes ephemerum_by_people.person(:last_name),            :as => :author_last_name
    indexes ephemerum_by_organisations.organisation(:name),    :as => :author_name
    indexes ephemerum_about_people.person(:first_name),        :as => :subject_first_name
    indexes ephemerum_about_people.person(:last_name),         :as => :subject_last_name
    indexes ephemerum_about_organisations.organisation(:name), :as => :subject_name
    indexes ephemerum_about_productions.production(:title),    :as => :production_title
    indexes ephemerum_about_genres.genre(:name_nl),            :as => :genre_name_nl
    indexes ephemerum_about_genres.genre(:name_fr),            :as => :genre_name_fr
    indexes ephemerum_about_genres.genre(:name_en),            :as => :genre_name_en
    indexes warehouse(:barcode),                               :as => :barcode

    set_property :delta => :delayed
  end

  def creation_date
    self.date
  end

  def appearance_date
    date
  end

  def self.base_class
    Ephemerum
  end

end
