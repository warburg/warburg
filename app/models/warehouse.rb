class Warehouse < ActiveRecord::Base
  include ActiveRecordExtensions

  acts_as_taggable

  belongs_to :box_type
  stampable

  relations [:contains_documents]
  search_fields [:box_location, :barcode]

  readonly_fields [:barcode]

  has_many :archive_parts, :dependent => :nullify
  has_many :audio_video_media, :dependent => :nullify
  has_many :book_copies, :dependent => :nullify
  has_many :ephemera, :dependent => :nullify
  has_many :periodical_issues, :dependent => :nullify

  has_many :about_people, :through => :warehouse_about_people, :source => :person
  has_many :warehouse_about_people, :dependent => :destroy

  has_many :about_organisations, :through => :warehouse_about_organisations, :source => :organisation
  has_many :warehouse_about_organisations, :dependent => :destroy

  has_many :about_productions, :through => :warehouse_about_productions, :source => :production
  has_many :warehouse_about_productions, :dependent => :destroy

  set_friendly_id [:box_location, :barcode]

  acts_as_barby :field => :box_id, :prefix => "5"

  before_create :generate_barcode

  def self.sticker_options
    {:left_margin => 0.mm,
     :right_margin => 0.mm,
     :top_margin => 0.mm,
     :bottom_margin => 0.mm}
  end

  def self.barcode_for(value)
    Barcode.barcode_for('5', 9, value)
  end

  def generate_barcode
    self.barcode = (Warehouse.maximum(:barcode).to_i + 1).to_s
  end

  def title
    "#{box_location}/#{barcode}"
  end

  def to_s
    title
  end

  def contains_documents
    archive_parts + audio_video_media + book_copies + ephemera + periodical_issues
  end

  def self.order_field
    'cached_slug'
  end

  def self.similar_field
    'cached_slug'
  end

end
