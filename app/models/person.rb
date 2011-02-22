require 'active_record_ext'

class Person < ActiveRecord::Base

  include DeltaFlag
  include ActiveRecordExtensions

  field_sequence [:name, :first_name, :last_name, :alumnus_organisations, :language_id, :gender_id, :country_id, :city, :birthdate_id, :death_date_id]
  admin_fields [:birthdate, :birthdate_id, :death_date, :death_date_id, :name, :key_name, :city]
  readonly_fields [:name]
  relations [:production_by_people_ordered, :author_of_documents, :subject_of_documents]
  search_fields [:first_name, :last_name]

  acts_as_versioned
  acts_as_taggable

  belongs_to :language
  belongs_to :gender
  belongs_to :birthdate, :class_name => "DateIsaar"
  belongs_to :death_date, :class_name => "DateIsaar"

  set_friendly_id [:first_name, :last_name]

  belongs_to :country

  belongs_to :alias_of, :class_name => 'Person'
  stampable

  has_many :alumni, :include => [:organisation, {:person => [:birthdate, :death_date]}], :dependent => :nullify
  has_many :alumnus_organisations, :through => :alumni, :source => :organisation

  has_many :audio_video_titles_by, :through => :audio_video_title_by_people, :source => :audio_video_title
  has_many :audio_video_title_by_people, :include => [{:audio_video_title => :creation_date}, {:person => [:birthdate, :death_date]}, :function], :dependent => :destroy

  has_many :audio_video_titles_about, :through => :audio_video_title_about_people, :source => :audio_video_title
  has_many :audio_video_title_about_people, :include => [{:audio_video_title => :creation_date}, {:person => [:birthdate, :death_date]}], :dependent => :destroy

  has_many :archive_parts_about, :through => :archive_part_about_people, :source => :archive_part
  has_many :archive_part_about_people, :include => [:archive_part, {:person => [:birthdate, :death_date]}], :dependent => :destroy

  has_many :articles_about, :through => :article_about_people, :source => :article
  has_many :article_about_people, :include => [{:article => :periodical_issue}, {:person => [:birthdate, :death_date]}], :dependent => :destroy

  has_many :press_cuttings_about, :through => :press_cutting_about_people, :source => :press_cutting
  has_many :press_cutting_about_people, :include => [:press_cutting, {:person => [:birthdate, :death_date]}], :dependent => :destroy

  has_many :articles_by, :through => :article_by_people, :source => :article
  has_many :article_by_people, :include => [{:article => :periodical_issue}, {:person => [:birthdate, :death_date]}, :function], :dependent => :destroy

  has_many :press_cuttings_by, :through => :press_cutting_by_people, :source => :press_cutting
  has_many :press_cutting_by_people, :include => [:press_cutting, {:person => [:birthdate, :death_date]}, :function], :dependent => :destroy

  has_many :book_titles_by, :through => :book_title_by_people, :source => :book_title
  has_many :book_title_by_people, :include => [:book_title, {:person => [:birthdate, :death_date]}, :function], :dependent => :destroy

  has_many :book_titles_about, :through => :book_title_about_people, :source => :book_title
  has_many :book_title_about_people, :include => [:book_title, {:person => [:birthdate, :death_date]}], :dependent => :destroy

  has_many :ephemera_by, :through => :ephemerum_by_people, :source => :ephemerum
  has_many :ephemerum_by_people, :include => [:ephemerum, {:person => [:birthdate, :death_date]}, :function], :dependent => :destroy

  has_many :ephemera_about, :through => :ephemerum_about_people, :source => :ephemerum
  has_many :ephemerum_about_people, :include => [:ephemerum, {:person => [:birthdate, :death_date]}], :dependent => :destroy

  has_many :ico_titles_by, :through => :ico_title_by_people, :source => :ico_title
  has_many :ico_title_by_people, :include => [:ico_title, {:person => [:birthdate, :death_date]}, :function], :dependent => :destroy

  has_many :ico_titles_about, :through => :ico_title_about_people, :source => :ico_title
  has_many :ico_title_about_people, :include => [:ico_title, {:person => [:birthdate, :death_date]}], :dependent => :destroy

  has_many :productions_by, :through => :production_by_people, :source => :production
  has_many :production_by_people, :include => [{:production => :season}, {:person => [:birthdate, :death_date]}, :function], :dependent => :destroy

  has_many :about_genres, :through => :person_about_genres, :source => :genre
  has_many :person_about_genres, :include => [{:person => [:birthdate, :death_date]}]


  def author_of_documents
    @author_documents ||= (audio_video_title_by_people + article_by_people + press_cutting_by_people + book_title_by_people + ephemerum_by_people + ico_title_by_people).sort{|d1, d2| d2.other_side(self).sortable_date <=> d1.other_side(self).sortable_date}
  end

  def subject_of_documents
    @subject_of_documents ||= (audio_video_title_about_people + article_about_people + press_cutting_about_people +
    book_title_about_people + ephemerum_about_people + ico_title_about_people).sort{|d1, d2| d2.other_side(self).sortable_date <=> d1.other_side(self).sortable_date}
  end

  def before_save
    self.name = "#{first_name} #{last_name}"
  end

  def title
    "#{first_name} #{last_name}"
  end

  # Which field is used for ordering? Used in MainKlassController (amongst others). Default is 'title'.
  def self.order_field
    'last_name'
  end

  # Which field is used for searching Used in MainKlassController (amongst others). Default is 'title'.
  def self.similar_field
    'name'
  end

  def to_s
    title
  end

  def production_by_people_ordered
    @production_by_people_ordered ||=
      production_by_people.sort do |a, b|
        if a.production.season.nil?
          1
        elsif b.production.season.nil?
          -1
        else
          -(a.production.season <=> b.production.season)
        end
      end
  end

end
