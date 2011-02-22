class BookTitle < Document
  include Antilope

  set_table_name "book_titles"
  acts_as_versioned :table_name => "book_title_versioned", :association_options => { :dependent => :nullify }

  acts_as_taggable

  field_sequence [:title, :title_extra, :publication_year, :ean, :library_location, :warehouse]
  relations [:author_relations, :subject_relations, :about_genres, :book_copies, :book_title_languages, :book_title_impressums]

  set_friendly_id :title
  
  stampable
  
  belongs_to :part_of_book_title, :class_name => 'BookTitle'

  has_many :book_copies, :dependent => :nullify
  
  has_many :by_people, :through => :book_title_by_people, :source => :person
  has_many :book_title_by_people, :dependent => :destroy
  
  has_many :about_people, :through => :book_title_about_people, :source => :person
  has_many :book_title_about_people, :dependent => :destroy
  
  has_many :by_organisations, :through => :book_title_by_organisations, :source => :organisation
  has_many :book_title_by_organisations, :dependent => :destroy
  
  has_many :about_organisations, :through => :book_title_about_organisations, :source => :organisation
  has_many :book_title_about_organisations, :dependent => :destroy
  
  has_many :about_productions, :through => :book_title_about_productions, :source => :production
  has_many :book_title_about_productions, :dependent => :destroy
  
  has_many :orders, :through => :book_title_orders, :source => :order
  has_many :book_title_orders, :dependent => :destroy

  has_many :about_genres, :through => :book_title_about_genres, :source => :genre
  has_many :book_title_about_genres
  
  has_many :book_title_languages
  
  has_many :book_title_impressums
  
  define_index do
      indexes title
      indexes tags(:name),                                        :as => :tag
      indexes book_title_by_people.person(:first_name),           :as => :author_first_name
      indexes book_title_by_people.person(:last_name),            :as => :author_last_name
      indexes book_title_by_organisations.organisation(:name),    :as => :author_name
      indexes book_title_about_people.person(:first_name),        :as => :subject_first_name
      indexes book_title_about_people.person(:last_name),         :as => :subject_last_name
      # indexes book_title_about_organisations.organisation(:name), :as => :subject_name
      # indexes book_title_about_productions.production(:title),    :as => :production_title
      indexes book_title_about_genres.genre(:name_nl),            :as => :genre_name_nl
      indexes book_title_about_genres.genre(:name_fr),            :as => :genre_name_fr
      indexes book_title_about_genres.genre(:name_en),            :as => :genre_name_en
      indexes book_copies.barcode,                                :as => :barcode
      
      set_property :delta => :delayed
    end

  

  def validate_ean
    if self.ean
      i = 1
      sum = 0
      self.ean.each_char do |c|
        if i <= 12
          if i.even?
            sum += c.to_i * 3
          else
            sum += c.to_i
          end
        end
        i += 1
      end
      checksum = self.ean[-1..-1].to_i
      remainder = sum % 10
      checksum == (10 - remainder) % 10
    else
      true
    end
  end

  def appearance_date
    publication_year
  end

  def library_location
    book_copies.collect{|bc| bc.library_location}.join(', ')  
  end

  def warehouse
    book_copies.collect{|bc| bc.warehouse}.join(', ')
  end

  def self.base_class
    BookTitle
  end
  
  def self.relations_in_sequence
    [:book_title_by_people, :book_title_by_organisations, :book_title_about_people, :book_title_about_organisations, :book_title_about_productions, :book_title_about_genres, :book_title_languages, :book_title_orders, :book_title_impressums]
  end

  protected

  def validate
    errors.add(:ean, "message.ean_not_valid") unless validate_ean
  end
  
end
