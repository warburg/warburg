class Relationship < ActiveRecord::Base
  include RelationshipUtil
  stampable

  class_inheritable_accessor :relation_attributes_arr

  def to_param
    id.to_s
  end
  
  def self.relation_attributes(arr = nil)
    self.relation_attributes_arr ||= []
    if arr
      new_fields = Array(arr).collect{|f|f.to_s}
      self.relation_attributes_arr += new_fields
    else
      self.relation_attributes_arr
    end
  end

  def author
    if respond_to? 'person'
      person
    else
      organisation
    end
  end

  def subject
    if respond_to? 'person'
      person
    elsif respond_to? 'production'
      production
    else
      organisation
    end
  end

  def title
    self.class.name
  end
  
  def to_s
    title
  end
  
end
