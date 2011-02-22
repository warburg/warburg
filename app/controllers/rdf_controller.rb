class RDFController < ApplicationController
  include Userstamp
  
  def show
    name = params[:name].singularize.camelize
    object = eval("#{name}.find(params[:id])")
    respond_to do |format|
      format.rdf  { render :template => 'shared/show', :locals => {:object => object } }
    end
  end
  
end
