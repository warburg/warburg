require 'active_record_ext'

class Season < ActiveRecord::Base
  set_friendly_id :name

  relations [:productions, :documents]

  has_many :productions, :dependent => :nullify
  has_many :ephemera, :dependent => :nullify
  has_many :ico_titles, :dependent => :nullify

  validates_presence_of :start_year
  validates_uniqueness_of :start_year

  before_save :define_end_year_and_name

  # default_scope :order => self.order_field
  named_scope :visible, :conditions => {:visible => true}

  stampable

  def to_s
    name
  end

  def title
    name
  end

  def define_end_year_and_name
    self.end_year = self.start_year + 1
    self.name = "#{start_year}-#{end_year}"
  end

  # Which field is used for ordering? Used in MainKlassController (amongst others). Default is 'title'.
  def self.order_field
    'name'
  end

  # Which field is used for searching Used in MainKlassController (amongst others). Default is 'title'.
  def self.similar_field
    'name'
  end

  def documents
    ephemera + ico_titles
  end

  def <=>(other)
    self_year = self.start_year
    other_year = other.start_year
    comp_nilsafe(self_year, other_year)
  end

  def self.fits_in_dropdown_box?
    true
  end

  def comp_nilsafe(a,b)
    if a.nil?
      if b.nil?
        0
      else
        -1
      end
    else
      if b.nil?
        1
      else
        a <=> b
      end
    end
  end

  def after_save
    if visible_changed? && !new_record?
      Production.all(:conditions => {:season_id => self.id}).each{|p| p.save(false)}
    end
  end

end
