class Donation < ActiveRecord::Base
  set_friendly_id :title

  acts_as_taggable

  relations [:donors, :contains_documents]

  belongs_to :organisation
  belongs_to :person
  belongs_to :donor_organisation, :class_name => 'Organisation'
  belongs_to :donor_person, :class_name => 'Person'

  has_many :archive_parts, :dependent => :nullify
  has_many :audio_video_media, :dependent => :nullify
  has_many :book_copies, :dependent => :nullify
  has_many :ephemera, :dependent => :nullify
  has_many :periodical_issues, :dependent => :nullify

  has_many :about_genres, :through => :donation_about_genres, :source => :genre
  has_many :donation_about_genres


  stampable

  field_sequence [:title]

  def donors
    [donor_organisation, donor_person].compact
  end

  def contains_documents
    archive_parts + audio_video_media + book_copies + ephemera + periodical_issues
  end


end

