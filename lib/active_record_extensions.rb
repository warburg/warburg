module ActiveRecordExtensions
  
  def self.included(base)
    base.extend(ClassMethods)
    base.class_eval do
      include InstanceMethods
    end
  end
  
  module ClassMethods
  end
  
  module InstanceMethods
    
    def skip_stamp
      self.class.record_userstamp = false
      self.class.record_timestamps = false
      yield
      self.class.record_timestamps = true
      self.class.record_userstamp = true
    end
    
    def increment_view_counter_skip_stamp
      # skip_stamp { increment_view_counter }
      10.times do |index|
        begin
          skip_stamp { increment_view_counter }
          break
        rescue
          logger.warn "Error occured when updating view count, trying again!"
        end
      end
    end
    
    def increment_view_counter
      self.views ||= 0
      self.views += 1
      self.viewed_at = Time.now
      self.save(false)
    end
    
  end
  
end