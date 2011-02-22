require 'active_record_ext'

class CdbEvent < ActiveRecord::Base
  has_many :cdb_category_cdb_events, :dependent => :destroy
  has_many :cdb_categories, :through => :cdb_category_cdb_events

  has_many :cdb_timestamps

  belongs_to :cdb_location
  belongs_to :cdb_organisation

  has_many :cdb_event_details

  has_one :cdb_contactinfo, :dependent => :destroy

  has_one :cdb_related_production, :dependent => :destroy
  has_many :cdb_parent_events, :dependent => :destroy

  before_save :update_title_nl

  set_friendly_id :title_permalink

  field_sequence [:cdb_location_id, :cdb_organisation_id,
                  :cdb_timestamps, :categories, :cdb_contactinfo, :cdb_event_details, :cdb_related_production,
                  :cdb_parent_events]
  hidden_fields [:title_nl]

  def update_title_nl
    self.title_nl = title('nl')
  end

  def title_permalink
    title('nl')
  end

  def title(lang = nil)
    lang = I18n.locale unless lang
    event_detail = cdb_event_details.first(:conditions => ["language_id = ?", Language.find_by_locale(lang).id]) || cdb_event_details.first
    event_detail.title rescue nil
  end

  def categories
    cdb_categories.collect{|category| category.text}.uniq
  end

  def self.order_field
    'title_nl'
  end

end
