# ActsAsSimilar
module PgTrgm
  module Acts
    module Similar

      def self.included(base)
        base.extend(ClassMethods)
        class << base
          alias_method_chain :validate_find_options, :similar
          alias_method_chain :validate_calculation_options, :similar
          alias_method_chain :construct_finder_sql, :similar
          alias_method_chain :construct_calculation_sql, :similar
        end
      end

      module ClassMethods

        def validate_find_options_with_similar(options) #:nodoc:
          options.assert_valid_keys(ActiveRecord::Base::instance_eval('VALID_FIND_OPTIONS') << :similar)
        end

        def validate_calculation_options_with_similar(operation, options = {})
          options.assert_valid_keys(ActiveRecord::Calculations::CALCULATIONS_OPTIONS << :similar)
        end

        def construct_finder_sql_with_similar(options)
          if similar = options[:similar]
            options[:order] = "sml DESC, #{similar[:field].to_s}"
            options[:select] = "*, similarity(#{similar[:field].to_s}, #{sanitize(similar[:value])}) as sml"
            add_similar_condition!(options)
          end
          construct_finder_sql_without_similar(options)
        end

        def construct_calculation_sql_with_similar(operation, column_name, options)
          add_similar_condition!(options) if options[:similar]
          construct_calculation_sql_without_similar(operation, column_name, options)
        end

        private

          def add_similar_condition!(options)
            similar_condition = "#{options[:similar][:field].to_s} % ?"
            options[:conditions] ||= [""]
            if options[:conditions][0].blank?
              options[:conditions][0] = similar_condition
            else
              options[:conditions][0] = "#{similar_condition} OR #{options[:conditions][0]}"
            end
            options[:conditions].insert(1, options[:similar][:value])
          end

      end # class methods

    end
  end
end
