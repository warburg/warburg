require 'active_record_ext'

class Document < ActiveRecord::Base
  include DocumentBase
  include ActiveRecordExtensions
  self.inheritance_column = 'class_name'
  has_many :document_indices, :as => :document, :dependent => :delete_all
  invisible_relations [:document_indices]

  def generate_indices
    document_indices.clear
    document_indices << DocumentIndex.create(:key => self.title)
    if self.respond_to?('tags')
      tags.each do |tag|
        document_indices << DocumentIndex.create(:key => tag.name)
      end
    end
    if self.respond_to?('authors')
      authors.each do |author|
        document_indices << DocumentIndex.create(:key => author.title)
      end
    end
    if self.respond_to?('subjects')
      subjects.each do |subject|
        document_indices << DocumentIndex.create(:key => subject.title)
      end
    end

    if self.respond_to?('genres')
      genres.each do |genre|
        document_indices << DocumentIndex.create(:key => genre.name_nl)
        document_indices << DocumentIndex.create(:key => genre.name_fr)
        document_indices << DocumentIndex.create(:key => genre.name_en)
        document_indices << DocumentIndex.create(:key => genre.search_alternatives)
      end
    end
  end

  def sortable_date
    if self.respond_to?('appearance_date') && appearance_date.present? && !appearance_date.is_a?(String) && !appearance_date.is_a?(Integer)
      begin
        appearance_date.to_date
      rescue
        created_at.to_time.to_date
      end
    elsif self.respond_to?('date') && date.present?
      begin
        date.to_date
      rescue
        created_at.to_time.to_date
      end
    else
      created_at.to_time.to_date
    end
  end


end
