class Periodical < ActiveRecord::Base
  include ActiveRecordExtensions
  include Antilope

  field_sequence [:title, :title_extra, :url, :issn, :antilope_index, :holdings, :subscription_running, :subscription_type, :subscription_periodicity, :subscription_end_date, :subscription_note]

  stampable
  # belongs_to :organisation
  set_friendly_id :title

  acts_as_taggable

  relations [:contains_documents, :periodical_issues_ordered]

  has_many :press_cuttings, :dependent => :nullify
  has_many :periodical_issues, :dependent => :nullify

  has_many :periodical_impressums, :dependent => :nullify
  has_many :impressums, :through => :periodical_impressums

  has_many :periodical_languages, :dependent => :nullify
  has_many :languages, :through => :periodical_languages

  has_many :about_genres, :through => :periodical_about_genres, :source => :genre
  has_many :periodical_about_genres, :dependent => :nullify

  def contains_documents
    press_cuttings
  end

  def periodical_issues_ordered
    periodical_issues.sort_by { |periodical_issue| periodical_issue.search_date.to_s }
  end
end
