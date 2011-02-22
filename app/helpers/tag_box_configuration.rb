module TagBoxConfiguration
  include BoxConfiguration

  def columns_for_taggings
    cols = []
    cols << {:title => 'title', :field => lambda {|obj| link_to(obj.taggable.title, obj.taggable)}}
    cols << {:title => 'type', :field => lambda {|obj| t("class.#{obj.taggable.class.name}")}}
    cols
  end
end