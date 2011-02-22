module ActiveRecord
  class Base
    named_scope :visible, :conditions => {}
  end
end