class Postit < ActiveRecord::Base
  stampable

  belongs_to :postitable, :polymorphic => true
  belongs_to :user
  belongs_to :language
  
  def self.for(object, user)
    if user
      conditions = {:postitable_id => object.id, :postitable_type => object.class.name}
      unless user.admin?
        conditions.merge!({:user_id => user.id})
      end
      all(:conditions => conditions)
    end
  end
  
  def to_s
    "<Postit: #{text}>"
  end
end
