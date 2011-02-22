class DetailsController < ApplicationController
  include Userstamp
  def index
    parent_param_key, parent_param_value = params.select {|k,v| k.to_s.ends_with?('_id')}[0]
    parent_class = eval(parent_param_key[0..-4].classify)
    @parent = parent_class.find(parent_param_value)
    @relation_type = "#{controller_name}_ordered"
    
    if @relation_type.starts_with?("nested_")
      @relation_type = @relation_type[7..-1]
    end
    if !@parent.respond_to?(@relation_type)
      @relation_type = @relation_type[0..-9]
    end
    render :template => '/shared/full_box'
  end
  
end