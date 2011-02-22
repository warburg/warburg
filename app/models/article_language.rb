class ArticleLanguage < ActiveRecord::Base
  include RelationshipUtil
  class_inheritable_accessor :relation_attributes_arr
  
  belongs_to :article
  belongs_to :language
  belongs_to :language_role
  
  validates_presence_of :article
  validates_presence_of :language
  
  stampable
  
  def self.relation_attributes(arr = nil)
    self.relation_attributes_arr ||= []
    if arr
      new_fields = Array(arr).collect{|f|f.to_s}
      self.relation_attributes_arr += new_fields
    else
      self.relation_attributes_arr
    end
  end
  
end
