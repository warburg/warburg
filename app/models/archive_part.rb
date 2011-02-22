class ArchivePart < Document
  set_table_name "archive_parts"
  acts_as_versioned :table_name => "archive_part_versioned", :association_options => { :dependent => :nullify }
  
  relations [:author_relations, :subject_relations]

  set_friendly_id :title
  
  stampable
  belongs_to :warehouse
  belongs_to :donation
  
  has_many :about_organisations, :through => :archive_part_about_organisations, :source => :organisation
  has_many :archive_part_about_organisations, :dependent => :destroy
  
  has_many :about_productions, :through => :archive_part_about_productions, :source => :production
  has_many :archive_part_about_productions, :dependent => :destroy
  
  has_many :about_people, :through => :archive_part_about_people, :source => :person
  has_many :archive_part_about_people, :dependent => :destroy
  
  has_many :about_genres, :through => :archive_part_about_genres, :source => :genre
  has_many :archive_part_about_genres
  
  define_index do
    indexes title
    indexes archive_part_about_people.person(:first_name),        :as => :subject_first_name
    indexes archive_part_about_people.person(:last_name),         :as => :subject_last_name
    indexes archive_part_about_organisations.organisation(:name), :as => :subject_name
    indexes archive_part_about_productions.production(:title),    :as => :production_title
    indexes archive_part_about_genres.genre(:name_nl),            :as => :genre_name_nl
    indexes archive_part_about_genres.genre(:name_fr),            :as => :genre_name_fr
    indexes archive_part_about_genres.genre(:name_en),            :as => :genre_name_en
    indexes warehouse(:barcode),                                  :as => :barcode
    
    set_property :delta => :delayed
  end  

  def self.base_class
    ArchivePart
  end

end
