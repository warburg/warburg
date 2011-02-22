class RdfschemasController < ApplicationController
  include Userstamp
  def show
    if params[:classname] == 'person'
      respond_to do |format|
        format.rdf {render :template => 'rdfs/person', :layout => false}
      end
    end
  end
end
