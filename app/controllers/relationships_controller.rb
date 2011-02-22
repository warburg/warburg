class RelationshipsController < DetailsController
  include Userstamp
  def destroy
    if admin?
      @relation = eval(resource_classname(request)).find(params[:id])
      @relation.destroy
      respond_to do |format|
        format.html { render(:nothing => true) }
        format.js { render :layout => false }
      end
    end
  end

  def update
    if admin?
      @relation = eval(resource_classname(request)).find(params[:id])
      @relation.update_attributes(params[resource_classname(request).underscore.to_sym])
      
      respond_to do |format|
        format.js { render :nothing => true }
      end
    end
  end

  def create
    #  "/relationships/:relationship_type/:parent_id/:object_id"
    if admin?
      @parent = eval(params[:parent_class]).find(params[:parent_id])
      @object = eval(params[:object_class]).find(params[:object_id])
      begin
        @relationship_class = eval(params[:relationship_type_reference].classify)
        @relationship = @relationship_class.create(params[:parent_class_reference] => @parent, params[:object_class_reference] => @object)
        # raise params[:object_class_reference].inspect
        @relationship_name = params[:relationship_type]
        @ul_id = @relationship_name# .pluralize
      rescue NameError
        # we're dealing with a belongs_to relation iso. a has_many
        @parent.update_attribute(params[:relationship_type].underscore, @object)
        @ul_id = @relationship_name = params[:relationship_type]
      end
      respond_to do |format|
        format.html { render :nothing => true }
        format.js   { render :layout => false }
      end
    end
  end
  
  def delete
    #raise params.inspect    
    if admin?
      @relation = params[:relationship_type]
      @relation_id = params[:child_id]      
      if @relation == "organisation_to_organisations" || @relation == "organisation_from_organisations"
        @relation_clazz = OrganisationRelation
      elsif @relation == "rerun_of"
        @relation_clazz = Production
      else
        @relation_clazz = @relation.classify.constantize rescue @relation_clazz = nil
        
      end
      @parent = params[:parent_class].constantize.find(params[:parent_id]) 
      @target = @parent.try(@relation)
      if @relation_clazz && @relation_clazz.new.is_a?(Relationship)
        @relation_clazz.delete(params[:child_id])
      elsif @target.is_a?(Array)    
        @target = @target.select{|t|t.id = params[:child_id]}[0]
        @parent.send(@relation).delete(@target)
      else
        @parent.update_attribute(@relation, nil)
        @relation = @parent.class.to_s.constantize.reflect_on_association(@relation.to_sym).options[:class_name].downcase
      end
      @relation = @relation == "organisation_to_organisations" || @relation == "organisation_from_organisations" ? "organisation_relation" : @relation
      @relation = @relation == "rerun_of" ? "production" : @relation
      respond_to do |format|
        format.html { render(:nothing => true) }
        format.js { render :layout => false }
      end
    end
  end
  
  private 
  
  def resource_classname(request)
    # request.path.split('/')[1].classify
    request.resource_classname
  end

end