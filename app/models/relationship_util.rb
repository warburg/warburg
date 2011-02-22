class WrongImplementationError < StandardError
end

class BadDataError < StandardError
end



module RelationshipUtil
  module ClassMethods
    # Returns the association that links to the object on the other side.
    def other_side_association(klazz)
      associations = self.reflect_on_all_associations(:belongs_to)
      classname = klazz.name.underscore.to_sym
      associations = associations.select{|assoc| !([classname] + [:creator, :updater, :function, :language_role]).include?(assoc.name)}
      if associations.size != 1
        raise WrongImplementationError.new("other_side not well defined for #{self.class}")
      end
      associations[0]
    end



    # Returns the class of other side of the relationship.
    def other_side_class(klazz)
      self.other_side_association(klazz).klass
    end
  end
  
  def self.included(base)
      base.extend(ClassMethods)
  end
  
  # Returns the other side of the relationship.
  def other_side(object)
    result = self.send(self.class.other_side_association(object.class).name)
    if result.nil?
      raise BadDataError.new("other_side is nil for #{self.inspect}. The calculated association was #{self.class.other_side_association(object.class)}")
    end
    result
  end
  
end