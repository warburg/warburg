class Article < Document
  set_table_name "articles"
  acts_as_versioned :table_name => "article_versioned", :association_options => { :dependent => :nullify }
  
  acts_as_taggable

  field_sequence [:title, :periodical_issue_id, :library_location, :warehouse]
  relations [:author_relations, :subject_relations]
  hidden_relations [:article_by_organisations]

  set_friendly_id :title

  belongs_to :periodical_issue
  stampable
  
  has_many :by_people, :through => :article_by_people, :source => :person
  has_many :article_by_people, :include => :person, :dependent => :destroy
  
  has_many :about_people, :through => :article_about_people, :source => :person
  has_many :article_about_people, :include => :person, :dependent => :destroy
  
  has_many :by_organisations, :through => :article_by_organisations, :source => :organisation
  has_many :article_by_organisations, :include => :organisation, :dependent => :destroy
  
  has_many :about_organisations, :through => :article_about_organisations, :source => :organisation
  has_many :article_about_organisations, :include => :organisation, :dependent => :destroy
  
  has_many :about_productions, :through => :article_about_productions, :source => :production
  has_many :article_about_productions, :include => :production, :dependent => :destroy

  has_many :about_genres, :through => :article_about_genres, :source => :genre
  has_many :article_about_genres
  
  has_many :article_languages, :dependent => :nullify
  
  define_index do
    indexes title
    indexes tags(:name),                                     :as => :tag
    indexes article_by_people.person(:first_name),           :as => :author_first_name
    indexes article_by_people.person(:last_name),            :as => :author_last_name
    indexes article_by_organisations.organisation(:name),    :as => :author_name
    indexes article_about_people.person(:first_name),        :as => :subject_first_name
    indexes article_about_people.person(:last_name),         :as => :subject_last_name
    indexes article_about_organisations.organisation(:name), :as => :subject_name
    indexes article_about_productions.production(:title),    :as => :production_title
    indexes article_about_genres.genre(:name_nl),            :as => :genre_name_nl
    indexes article_about_genres.genre(:name_fr),            :as => :genre_name_fr
    indexes article_about_genres.genre(:name_en),            :as => :genre_name_en
    indexes periodical_issue(:barcode),                      :as => :barcode
    
    set_property :delta => :delayed
  end

  def library_location
    periodical_issue.library_location if periodical_issue
  end
  
  def warehouse
    periodical_issue.warehouse if periodical_issue  
  end
  
  def creation_date 
    periodical_issue.date_text if periodical_issue
  end
  
  def appearance_date
    periodical_issue.date_text if periodical_issue
  end
  
  def self.relations_in_sequence
    [:article_languages, :periodical_issue, :article_by_people, :article_about_people, :article_about_organisations, :article_about_productions, :article_about_genres]
  end

  def self.base_class
    Article
  end

end
