require 'active_record_ext'

class AudioVideoMedium < ActiveRecord::Base
  include DocumentBase

  belongs_to :audio_video_medium_type
  belongs_to :donation
  belongs_to :warehouse
  
  belongs_to :copy_of, :class_name => 'AudioVideoMedium'
  belongs_to :source,  :class_name => 'Organisation'
  
  has_many :audio_video_title_on_media, :dependent => :destroy
  has_many :audio_video_titles, :through => :audio_video_title_on_media 

  set_friendly_id :library_location

  search_fields [:library_location]
  relations [:audio_video_title_on_media]
  
  readonly_fields [:barcode]
  
  stampable
  
  before_create :generate_barcode

  def self.barcode_for(value)
    Barcode.barcode_for('6', 9, value)
  end
  
  def generate_barcode
    self.barcode = (AudioVideoMedium.maximum(:barcode).to_i + 1).to_s
  end

  def self.sticker_options 
    {:left_margin => 5.mm,
     :right_margin => 5.mm,
     :top_margin => 14.mm, 
     :bottom_margin => 14.mm}
  end

  def title
    library_location
  end
  
  def self.order_field
    'library_location'
  end
end
