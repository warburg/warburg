class ProductionByOrganisation < Relationship
  
  belongs_to :production
  belongs_to :organisation
  belongs_to :function, :class_name => 'OrganisationFunction'
  
  validates_presence_of :production
  validates_presence_of :organisation
  
  relation_attributes [:function, :function_text]
  named_scope :visible, :conditions => {:visible => true} 
  
  def before_save
    self.visible = production.visible
    true
  end
  
end