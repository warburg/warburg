class Impressum < ActiveRecord::Base
  include ActiveRecordExtensions
  stampable

  set_friendly_id [:publisher, :publish_location]

  search_fields [:publisher]

  def to_s
    title
  end

  def title
    @title ||= "#{publisher}, #{publish_location}"
  end

  def self.order_field
    "publisher"
  end

end
