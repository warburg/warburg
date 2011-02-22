module SeasonBoxConfiguration
  include BoxConfiguration

  def columns_for_productions
    cols = []
    cols << { :title => 'name',
              :field => lambda {|obj| link_to obj.title, obj} }
    cols
  end


  def columns_for_documents
    cols = []
    cols << { :title => 'name',
              :field => lambda {|obj| link_to obj.title, obj} }

    cols << { :title => 'date',
              :field => lambda { |obj|
                          if obj.respond_to?('appearance_date')
                            date = obj.appearance_date
                            if date.is_a?(Time) || date.is_a?(Date) || date.is_a?(DateTime)
                              l(date)
                            else
                              date
                            end
                          else
                            nil
                          end
                       }
            }
    cols << { :title => 'type',
              :field => lambda {|obj| t "class.#{obj.class}"} }
    cols
  end

end
