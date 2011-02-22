require 'active_record_ext'

class Organisation < ActiveRecord::Base

  include DeltaFlag
  include ActiveRecordExtensions
  acts_as_versioned
  acts_as_taggable

  field_sequence [:name, :city, :country_id, :genres, :url, :festivals, :creation_date,
                  :start_activities_date, :end_activities_date, :cancellation_date,
                  :classification_code]

  admin_fields [:creation_date_id, :creation_date, :cancellation_date,
                :cancellation_date_id, :start_activities_date, :start_activities_date_id,
                :end_activities_date_id, :end_activities_date, :language, :language_id]

  relations [:organisation_relations, :production_by_organisations_ordered, :author_of_documents, :subject_of_documents, :grants]

  prefixed_order_field :name

  search_fields [:name]

  belongs_to :language
  belongs_to :creation_date, :class_name => "DateIsaar"
  belongs_to :cancellation_date, :class_name => "DateIsaar"
  belongs_to :start_activities_date, :class_name => "DateIsaar"
  belongs_to :end_activities_date, :class_name => "DateIsaar"
  belongs_to :legal_form

  validates_numericality_of :classification_code, :allow_nil => true

  stampable

  has_many :alumni, :include => :person, :dependent => :nullify
  has_many :alumnus_organisations, :through => :alumni, :source => :person

  has_many :audio_video_titles_by, :through => :audio_video_title_by_organisations, :source => :audio_video_title
  has_many :audio_video_title_by_organisations, :include => :audio_video_title, :dependent => :destroy

  has_many :audio_video_titles_about, :through => :audio_video_title_about_organisations, :source => :audio_video_title
  has_many :audio_video_title_about_organisations, :include => :audio_video_title, :dependent => :destroy

  has_many :archive_parts_about, :through => :archive_part_about_organisations, :source => :archive_part
  has_many :archive_part_about_organisations, :include => :archive_part, :dependent => :destroy

  has_many :articles_by, :through => :article_by_organisations, :source => :article
  has_many :article_by_organisations, :include => :article, :dependent => :destroy

  has_many :press_cuttings_by, :through => :press_cutting_by_organisations, :source => :press_cutting
  has_many :press_cutting_by_organisations, :include => :press_cutting, :dependent => :destroy

  has_many :articles_about, :through => :article_about_organisations, :source => :article
  has_many :article_about_organisations, :include => :article, :dependent => :destroy

  has_many :press_cuttings_about, :through => :press_cutting_about_organisations, :source => :press_cutting
  has_many :press_cutting_about_organisations, :include => :press_cutting, :dependent => :destroy

  has_many :book_titles_about, :through => :book_title_about_organisations, :source => :book_title
  has_many :book_title_about_organisations, :include => :book_title, :dependent => :destroy

  has_many :book_titles_by, :through => :book_title_by_organisations, :source => :book_title
  has_many :book_title_by_organisations, :include => :book_title, :dependent => :destroy

  has_many :ephemera_by, :through => :ephemerum_by_organisations, :source => :ephemerum
  has_many :ephemerum_by_organisations, :include => :ephemerum, :dependent => :destroy

  has_many :ephemera_about, :through => :ephemerum_about_organisations, :source => :ephemerum
  has_many :ephemerum_about_organisations, :include => :ephemerum, :dependent => :destroy

  has_many :ico_titles_about, :through => :ico_title_about_organisations, :source => :ico_title
  has_many :ico_title_about_organisations, :include => :ico_title, :dependent => :destroy

  has_many :ico_titles_by, :through => :ico_title_by_organisations, :source => :ico_title
  has_many :ico_title_by_organisations, :include => :ico_title, :dependent => :destroy

  has_many :productions_by, :through => :production_by_organisations, :source => :production
  has_many :production_by_organisations, :include => :production

  has_many :venues, :through => :organisation_venues, :source => :venue
  has_many :organisation_venues, :include => :venue

  has_many :festivals, :dependent => :nullify
  has_many :grants, :dependent => :nullify

  has_many :organisations_to, :through => :organisation_to_organisations, :source => :organisation_to
  has_many :organisation_to_organisations, :foreign_key => 'organisation_from_id', :class_name => "OrganisationRelation", :include => :organisation_to

  has_many :organisations_from, :through => :organisation_from_organisations, :source => :organisation_from
  has_many :organisation_from_organisations, :foreign_key => 'organisation_to_id', :class_name => "OrganisationRelation", :include => :organisation_from

#  has_many :organisation_relations_from, :class_name => 'OrganisationRelation', :foreign_key => 'from_id'
#  has_many :organisation_relations_to,   :class_name => 'OrganisationRelation', :foreign_key => 'to_id'

  has_many :about_genres, :through => :organisation_about_genres, :source => :genre
  has_many :organisation_about_genres, :include => :genre, :dependent => :destroy

  has_many :organisation_impressums

  belongs_to :country

  set_friendly_id :name

  def author_of_documents
    @author_of_documents ||= (audio_video_title_by_organisations + article_by_organisations + press_cutting_by_organisations + book_title_by_organisations + ephemerum_by_organisations + ico_title_by_organisations).sort{|d1, d2| d2.other_side(self).sortable_date <=> d1.other_side(self).sortable_date}
  end

  def subject_of_documents
    @subject_of_documents ||= (audio_video_title_about_organisations + archive_part_about_organisations + article_about_organisations + press_cutting_about_organisations + book_title_about_organisations + ephemerum_about_organisations + ico_title_about_organisations).sort{|d1, d2| d2.other_side(self).sortable_date <=> d1.other_side(self).sortable_date}
  end

  def genres
    @genres ||= begin
      genres = Hash.new
      productions_by.each do |production|
        production.about_genres.each do |genre|
          genres[genre] ||= 0
          genres[genre] += 1
        end
      end
      result = genres.sort{|a, b| -(a[1] <=> b[1])}
      result = result[0..5].collect{|a| a[0]}
      result.empty? ? nil : result
    end
  end

  def title
    name
  end

  # Which field is used for ordering? Used in MainKlassController (amongst others). Default is 'title'.
  def self.order_field
    'sorted_name'
  end

  # Which field is used for searching Used in MainKlassController (amongst others). Default is 'title'.
  def self.similar_field
    'name'
  end

  def self.fits_in_dropdown_box?
    true
  end

  def organisation_relations
    return @organisation_relations if @organisation_relations
    @organisation_relations = []
    organisation_from_organisations.each do |rel|
      rel.direction = 'from'
      @organisation_relations << rel
    end
    organisation_to_organisations.each do |rel|
      rel.direction = 'to'
      @organisation_relations << rel
    end
    @organisation_relations
  end

  def production_by_organisations_ordered
    production_by_organisations.sort do |a, b|
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
