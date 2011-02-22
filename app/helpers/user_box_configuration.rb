module UserBoxConfiguration
  include BoxConfiguration

  def columns_for_postits
    cols = []
    cols << { :title => 'text',
              :field => lambda {|obj| obj.text} }
    cols << { :title => 'subject',
              :field => lambda {|obj| link_to(obj.postitable, obj.postitable) if obj.postitable} }
    cols
  end

  def columns_for_edits
    cols = []
    cols << {:title => 'object',
             :field => lambda {|obj| link_to(obj.to_s, obj)} }
    cols
  end
    
end
