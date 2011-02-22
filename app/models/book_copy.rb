require 'active_record_ext'

class BookCopy < ActiveRecord::Base
  include ActiveRecordExtensions

  stampable
  set_friendly_id :title

  cloneable
  ignore_cloning [:barcode, :permalink]

  readonly_fields [:barcode]

  belongs_to :book_title
  belongs_to :warehouse
  belongs_to :donation

  acts_as_barby(:field => :barcode)

  field_sequence [:book_title_id]

  before_create :generate_barcode

  def self.barcode_for(value)
    Barcode.barcode_for('2', 9, value)
  end

  def generate_barcode
    self.barcode = (BookCopy.maximum(:barcode).to_i + 1).to_s
  end

  def self.sticker_options
    {:left_margin => 5.mm,
     :right_margin => 5.mm,
     :top_margin => 14.mm,
     :bottom_margin => 14.mm}
  end

  def title
    book_title.title.to_s if (book_title && book_title.title)
  end

  def self.order_field
    'book_title_id'
  end

end
