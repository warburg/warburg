class ErrorReport < ActiveRecord::Base
  stampable

  belongs_to :error_reportable, :polymorphic => true
  belongs_to :user, :foreign_key => :creator_id

  def self.for(object, user)
    if user
      conditions = {:error_reportable_id => object.id, :error_reportable_type => object.class.name}
      unless user.admin?
        conditions.merge!({:creator_id => user.id})
      end
      all(:conditions => conditions, :order => 'created_at asc')
    end
  end
  
  def self.has_active_error_reports?(object)
    !!first(:conditions => {:error_reportable_id => object.id, :error_reportable_type => object.class.name, :fixed => false})
  end

end
