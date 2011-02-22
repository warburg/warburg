class ProductionByPerson < Relationship
  
  belongs_to :production
  belongs_to :person
  belongs_to :function, :class_name => "PersonFunction"
  
  validates_presence_of :production
  validates_presence_of :person

  relation_attributes [:function, :role]

  named_scope :visible, :conditions => {:visible => true} 
  
  def before_save
    self.visible = production.visible
    true
  end
  
  
end