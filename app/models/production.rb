require 'active_record_ext'

class Production < ActiveRecord::Base

  include DeltaFlag
  include ActiveRecordExtensions

  validates_numericality_of :target_audience_from, :allow_nil => true
  validates_numericality_of :target_audience_to, :allow_nil => true
  stampable
  cloneable [:production_languages, :production_by_organisations, :production_by_people, :production_about_genres]
  acts_as_taggable
  acts_as_versioned

  named_scope :visible, :conditions => {:visible => true}

  field_sequence [:title]
  search_fields  [ :title, :season_id ]

  relations [:production_by_organisations, :production_by_people, :subject_of_documents, :shows, :production_languages, :production_about_genres]

  hidden_relations [:book_title_about_productions, :press_cutting_about_productions, :ephemerum_about_productions,
                    :ico_title_about_productions, :audio_video_title_about_productions, :archive_part_about_productions,
                    :article_about_productions]

  belongs_to :rerun_of, :class_name => 'Production'
  belongs_to :season

  has_many :audio_video_titles_about, :through => :audio_video_title_about_productions, :source => :audio_video_title
  has_many :audio_video_title_about_productions, :dependent => :destroy

  has_many :archive_parts_about, :through => :archive_part_about_productions, :source => :archive_part
  has_many :archive_part_about_productions, :dependent => :destroy

  has_many :articles_about, :through => :article_about_productions, :source => :article
  has_many :article_about_productions, :dependent => :destroy

  has_many :press_cuttings_about, :through => :press_cutting_about_productions, :source => :press_cutting
  has_many :press_cutting_about_productions, :dependent => :destroy

  has_many :book_titles_about, :through => :book_title_about_productions, :source => :book_title
  has_many :book_title_about_productions, :dependent => :destroy

  has_many :ephemera_about, :through => :ephemerum_about_productions, :source => :ephemerum
  has_many :ephemerum_about_productions, :dependent => :destroy

  has_many :ico_titles_about, :through => :ico_title_about_productions, :source => :ico_title
  has_many :ico_title_about_productions, :dependent => :destroy

  has_many :by_organisations, :through => :production_by_organisations, :source => :organisation
  has_many :production_by_organisations, :dependent => :destroy

  has_many :by_people, :through => :production_by_people, :source => :person
  has_many :production_by_people, :dependent => :destroy

  has_many :about_genres, :through => :production_about_genres, :source => :genre
  has_many :production_about_genres, :include => :genre, :dependent => :destroy

  has_many :production_languages
  has_many :languages, :through => :production_languages

  has_many :shows, :dependent => :nullify

  alias_attribute :name, :title

  set_friendly_id :title

  def before_save
    self.visible = season.visible if season
    true
  end

  def after_save
    if visible_changed? && !new_record?
      shows.each{|p| p.save!}
      production_by_people.each{|p| p.save(false)}
      production_by_organisations.each{|p| p.save(false)}
    end
  end

  def subject_of_documents
    @subject_of_documents ||= audio_video_title_about_productions + archive_part_about_productions + article_about_productions + press_cutting_about_productions + book_title_about_productions +
    ephemerum_about_productions + ico_title_about_productions
  end

  def authors
    @authors ||= by_people + by_organisations
  end

  def to_s
    season ? "#{title} (#{season})" : title
  end

  def search_title
    "#{title} (#{season})"
  end

end
