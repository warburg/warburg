class TagsController < ApplicationController
  include Userstamp
  include MainKlassController
  
  before_filter :login_required, :only => [:add, :destroy]
  
  def autocomplete_tags
    conditions = ["name like ?", "#{params[:q]}%"]
    query = "select distinct name from tags where "
    query << ActiveRecord::Base.send(:sanitize_sql_array, conditions)
    query << " order by name ASC limit 10"    
    @results = ActiveRecord::Base.connection.select_values(query)
    render :text => @results.join("\n")
  end
  
  def show
    @object = Tag.find(params[:id])
    render :template => 'main_klass/show'
  end
  
  def add
    @tags = params[:tagfield].split(',').collect{|t| t.strip }
    @object = eval("#{params[:object]}.find(params[:id])")
    @object.tag_list.add(@tags)
    @object.save
    @tags = @tags.collect {|tag| Tag.find_by_name(tag)}
    respond_to do |format|
      format.html { redirect_to(@object) }
      format.js { render :layout => false }
    end
  end

  def destroy
    if admin?
      if params[:object_class].nil?
        @tag = Tag.find(params[:id])
        @tag.destroy
        redirect_to root_path
      else
        @tag = params[:id]
        @object = eval("#{params[:object_class]}.find(params[:object_id])")
        @object.tag_list.remove(@tag)
        @object.save
        render :nothing => true
      end
    else
      redirect_to root_path
    end
  end


  
  protected
  
    def use_resource
      
    end

end
