class PeriodicalIssue < ActiveRecord::Base
  belongs_to :periodical
  belongs_to :warehouse
  belongs_to :donation
  belongs_to :part_of_issue, :class_name => 'PeriodicalIssue'

  has_many :articles, :dependent => :nullify

  relations [:articles]

  stampable

  set_friendly_id [:title, :volume, :number]

  search_fields [:title, :volume, :number, :search_date, :barcode]
  field_sequence [:title, :volume, :number, :search_date, :date_text, :library_location, :available, :barcode, :print_barcode]

  readonly_fields [:barcode]

  acts_as_barby(:field => :copy_id, :prefix => "4")

  before_create :generate_barcode

  def self.barcode_for(value)
    Barcode.barcode_for('4', 9, value)
  end

  def generate_barcode
    self.barcode = (PeriodicalIssue.maximum(:barcode).to_i + 1).to_s
  end

  def self.sticker_options
    {:left_margin => 13.mm,
     :right_margin => 13.mm,
     :top_margin => 33.mm,
     :bottom_margin => 33.mm}
  end

  def title
    result = @title
    if result.nil?
      result = ''
      if periodical && periodical.title
        result << periodical.title
      end
      result << '/'
      if volume
        result << volume.to_s
      end
      result << '/'
      if number
        result << number.to_s
      end
    end
    result
  end
end
