require 'active_record'

module SetFriendlyId
  module ClassMethods
    attr_accessor :attr_names
    
    def set_friendly_id(column_names = nil, extra_options = {})
      raise "Argument has to be a String or Array!" unless column_names.is_a?(Symbol) || column_names.is_a?(String) || column_names.is_a?(Array)
      
      self.attr_names = column_names
      
      options = {
        :use_slug           => true,
        :max_length         => 60,
        :approximate_ascii  => true,
        :sequence_separator => "-"
      }.merge(extra_options)
      
      has_friendly_id :generate_slug, options
    end
  end
  
  module InstanceMethods
    
    def generate_slug
      string_to_slug = self.class.attr_names.is_a?(Array) ? self.class.attr_names.map { |c| send(c) }.join(" ") : send(self.class.attr_names)
      string_to_slug = self.permalink.nil? || self.permalink.blank? ? string_to_slug : self.permalink      
      if sluggify(string_to_slug) == ""
        string_to_slug = Digest::SHA1.hexdigest("#{string_to_slug}#{Time.now.to_s.split(//).sort_by {rand}}")
      end
      string_to_slug
    end
    
    private
    
    def sluggify(string)
      if string.nil?
        ""
      else
        slug_string = FriendlyId::SlugString.new(string)
        slug_string.approximate_ascii!
        slug_string.normalize!
        slug_string == "new" || slug_string == "index" ? "" : slug_string
      end
    end
  end
end

ActiveRecord::Base.send :include, SetFriendlyId::InstanceMethods
ActiveRecord::Base.extend  SetFriendlyId::ClassMethods