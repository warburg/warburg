# ActsAsBarby
require "barby"
module Acts
  module Barcode
    
    class BarbyNotConfigured < StandardError; end
    
    def self.included(recipient)
      recipient.extend(ClassMethods)
      recipient.class_eval do
        include InstanceMethods
      end
    end

    module ClassMethods      
      def acts_as_barby(options={})
        opts = { :length => 9, :prefix => "" }.merge(options)
        class << self
          attr_accessor :barby_field, :barby_length, :barby_prefix
        end        
        self.barby_field  = opts[:field]
        self.barby_length = opts[:length]
        self.barby_prefix = opts[:prefix].to_s
      end
    end # class methods

    module InstanceMethods
      
      def barcode_value
        raise BarbyNotConfigured unless self.class.respond_to?(:barby_prefix) &&
                                        self.class.respond_to?(:barby_field)        
                
        if value = self.send(self.class.barby_field)
          length = self.class.barby_length - self.class.barby_prefix.length
          "*#{self.class.barby_prefix}#{value.to_s.rjust(length, '0')}*"
        end
      end
      
      def to_barby
        Barby::Code39.new(self.barcode_value, true)
      end
    end # instance methods    
  end
  
end