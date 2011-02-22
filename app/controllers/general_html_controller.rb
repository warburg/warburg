class GeneralHtmlController < ApplicationController
  
  skip_before_filter :login_required
  
  def show
    name = params[:name].singularize.camelize
    object = eval("#{name}.find_by_cached_slug(params[:id])")  
    respond_to do |format|
      format.html  { render :template => 'shared/show', :locals => {:object => object } }
    end
  rescue NameError
    render :file => "#{RAILS_ROOT}/public/404.html", :status => 404 and return
  end
  
end
