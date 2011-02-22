require 'active_record_visibility'

module ActiveRecord
  class Base
    class_inheritable_accessor :field_sequence_arr
    class_inheritable_accessor :admin_fields_arr
    class_inheritable_accessor :hidden_fields_arr
    class_inheritable_accessor :readonly_fields_arr
    class_inheritable_accessor :relations_arr
    class_inheritable_accessor :search_fields_arr
    class_inheritable_accessor :hidden_relations_arr
    class_inheritable_accessor :invisible_relations_arr
    class_inheritable_accessor :cloneable_relations_arr
    class_inheritable_accessor :ignored_columns_when_cloning_arr
    class_inheritable_accessor :allow_cloning
    class_inheritable_accessor :prefixed_order_field_text

    def self.field_sequence(arr = nil)
      if arr
        new_fields = Array(arr).collect{|f|f.to_s}
        self.field_sequence_arr = new_fields
      else
        self.field_sequence_arr || []
      end
    end
    
    def self.prefixed_order_field(field = nil)
      if field
        self.prefixed_order_field_text = field.to_s.empty? ? nil : field
      else
        self.prefixed_order_field_text
      end
    end
    
    def self.convertible_attributes_fields
      reflect_on_all_associations(:belongs_to).select{|ass| ass.class_name == 'DateIsaar'}.collect{|ass| ass.name}
    end

    def self.admin_fields(arr = nil)
      self.admin_fields_arr ||= []
      if arr
        new_fields = Array(arr).collect{|f|f.to_s}
        self.admin_fields_arr += new_fields
      else
        self.admin_fields_arr
      end
    end
    
    def self.cloneable(relations_to_clone = nil)
      self.allow_cloning = true
      self.cloneable_relations_arr ||= []
      if relations_to_clone
        new_fields = Array(relations_to_clone).collect { |f| f.to_s }
        self.cloneable_relations_arr += new_fields
      else
        self.cloneable_relations_arr
      end
    end
    
    def self.ignore_cloning(columns_to_ignore)
      self.ignored_columns_when_cloning_arr ||= []
      if columns_to_ignore
        new_fields = Array(columns_to_ignore).collect { |f| f.to_s }
        self.ignored_columns_when_cloning_arr += new_fields
      else
        slef.ignored_columns_when_cloning_arr
      end
    end
    
    def self.cloneable?
      self.allow_cloning
    end
    
    def self.cloneable_relations
      self.cloneable_relations_arr
    end
    
    def self.ignored_columns_when_cloning
      self.ignored_columns_when_cloning_arr ||= []
    end

    admin_fields [:updated_at, :old_id, :viewed_at, :creator_id, :lock_version,
                  :id, :version, :updater_id, :views, :publicid, :created_at,
                  :cached_slug, :classification_code, :subscription_running,
                  :subscription_type, :subscription_expiration_date, :number_count,
                  :subscription_note, :subscription_periodicity, :subscription_end_date,
                  :child_roles, :male_roles, :female_roles, :number_of_roles]

    def self.admin_field?(field)
      self.admin_fields.include?(field.to_s)
    end

    def self.hidden_fields(arr = nil)
      self.hidden_fields_arr ||= []
      if arr
        new_fields = Array(arr).collect{|f|f.to_s}
        self.hidden_fields_arr += new_fields
      else
        self.hidden_fields_arr
      end
    end

    hidden_fields [:old_id, :class_name, :delta, :cached_slug]

    def self.hidden_field?(field)
      self.hidden_fields.include?(field.to_s)
    end

    # These relations are hidden at first on the edit screen.
    def self.hidden_relations(arr = nil)
      self.hidden_relations_arr ||= []
      if arr
        new_relations = Array(arr).collect{|f|f.to_sym}
        self.hidden_relations_arr += new_relations
      else
        self.hidden_relations_arr
      end
    end

    # These relations are never shown.
    def self.invisible_relations(arr = nil)
      self.invisible_relations_arr ||= []
      if arr
        new_relations = Array(arr).collect{|f|f.to_sym}
        self.invisible_relations_arr += new_relations
      else
        self.invisible_relations_arr
      end
    end


    def self.readonly_fields(arr = nil)
      self.readonly_fields_arr ||= []
      if arr
        new_fields = Array(arr).collect{|f|f.to_s}
        self.readonly_fields_arr += new_fields
      else                                                
        self.readonly_fields_arr
      end
    end

    readonly_fields [:updated_at, :created_at, :updater_id, :creator_id, :views, :viewed_at, :version,
                     :lock_version, :id]

    def self.readonly_field?(field)
      self.readonly_fields.include?(field.to_s)
    end

    def self.relations(arr = nil)
      self.relations_arr ||= []
      if arr
        new_fields = Array(arr).collect{|f|f.to_s}
        self.relations_arr += new_fields
      else
        self.relations_arr
      end
    end

    # Define the fields that are used for the search forms. These are 'overwriteable': a definition
    # of search_fields in a subclass overwrites those of the parent class.
    # If no search fields are defined, ['title'] is used as the default. 
    def self.search_fields(arr = nil)
      if arr
        new_fields = Array(arr).collect{|f|f.to_s}
        self.search_fields_arr = new_fields
      else
        self.search_fields_arr || ['title']
      end
    end

    def self.similar_field
      'title'
    end

    def self.order_field
      if self.column_names.include?('title')
        'title'
      elsif self.column_names.include?('name')
        'name'
      elsif column_names.include?('name_nl')
        "name_#{I18n.locale}"
      elsif self.column_names.include?('description')
        'description'
      elsif column_names.include?('description_nl')
        "description_#{I18n.locale}"
      end
    end

    def to_s
      send(self.class.order_field).to_s
    end
    
    def self.fits_in_dropdown_box?
      count < 100
    end

    # Return all atomic relations (all that are defined as association in the class, and that have no :through parameter)
    def self.atomic_relations
      reflect_on_all_associations(:has_many).select{|obj| !obj.options.keys.include?(:through)}.collect{|obj|obj.name}
    end
    
    # Return all many-to-many relations
    def self.many_to_many_relations
      reflect_on_all_associations(:has_many).select{|obj| obj.options.keys.include?(:through)}
    end
    

    # Returns all relations that are editable with the selector.
    def self.editable_relations
      result = atomic_relations - [:language, :gender, :versions, :creator, :birthdate, :country, :updater, :death_date,
                          :taggings, :tags, :postits, :productions, :documents, :ico_titles, :ephemera, :creation_date,
                          :organisation_relations_to, :organisation_relations_from, :grants, :festivals, :shows,
                          :book_copies, :contains_documents, :archive_parts, :audio_video_media, :book_copies,
                          :ephemera, :periodical_issues, :articles, :press_cuttings, :alumnus_organisations]
      result.sort{|a, b| a.to_s <=> b.to_s}
    end
    
    def self.shown_relations
      editable_relations - hidden_relations - invisible_relations
    end

    def to_param
      if respond_to?('cached_slug')
        cached_slug.blank? ? id.to_s : cached_slug
      else
        id.to_s
      end
    end
    
    def self.param_field
      if self.new.respond_to?('cached_slug')
        'cached_slug'
      else
        'id'
      end
    end

    # Passes the (key, value) pairs of each attribute that is visible in the specified mode for a user with
    # the specified roles into a block.
    def each_field(mode = :all, roles = [])
      (self.class.field_sequence | self.attributes.keys).each do |key|
        value = self.send(key)
        condition =
                case mode
                  when :all 
                    true
                  when :show 
                    !((self.class.admin_field?(key) && !roles.include?(:admin)) || (value.blank? && value != false) || self.class.hidden_field?(key))
                  when :edit 
                    self.attributes.keys.include?(key) && !self.class.hidden_field?(key) && !self.class.readonly_field?(key) && self.respond_to?("#{key}=")
                end
        if condition 
          yield(key, value)
        end
      end
    end

    def localized(field)
      self.send("#{field}_#{I18n.locale}")
    end
    
    def has_active_error_reports?
      ErrorReport.has_active_error_reports?(self)
    end
    
    def search_title
      title
    end
    
    def after_destroy
      if Relationship.new.respond_to?("#{self.class.to_s.underscore}_id")
        relationships = Relationship.find(:all, :conditions => { "#{self.class.to_s.underscore}_id".to_sym => self })
        relationships.each { |r| r.destroy } if relationships.present?
      end
    end
    
    def before_save
      self.send("sorted_#{self.prefixed_order_field_text.to_s}=", convert_prefix_sort_field(self.prefixed_order_field_text)) unless self.prefixed_order_field_text.nil?
    end
    
    def convert_prefix_sort_field(sort_field)
      self.send(sort_field).gsub(/^(De |Het |Een )*/i, "")
    end

  end
end
