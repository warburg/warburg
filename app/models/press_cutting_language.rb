class PressCuttingLanguage < ActiveRecord::Base
  include RelationshipUtil
  class_inheritable_accessor :relation_attributes_arr
  
  belongs_to :press_cutting
  belongs_to :language
  belongs_to :language_role
  stampable
  
  validates_presence_of :press_cutting
  validates_presence_of :language

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
