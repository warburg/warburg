class EphemerumAboutProduction < Relationship
  
  belongs_to :ephemerum
  belongs_to :production
  
  validates_presence_of :ephemerum
  validates_presence_of :production
  
  # added because of ticket #519
  named_scope :visible, :conditions => {:visible => true} 
  
  def before_save
    self.visible = production.visible
    true
  end
  # end

end