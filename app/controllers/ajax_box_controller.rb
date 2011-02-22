class AjaxBoxController < ApplicationController
  
  # before_filter proc{ |c| c.request.xhr? || c.send(:access_denied) }

  def fetch
    @pid = params[:pid]
    @object = eval("#{params[:object]}.find(params[:id])")
    klazz = params[:klazz]
#    puts "Calling  #{klazz}BoxConfiguration.details_for_#{params[:relation]}"
    @dls = eval("class AClass; include #{klazz}BoxConfiguration; end").new.send("details_for_#{params[:relation]}")
    @dls.collect! {|box_detail| 
        detail = box_detail[:field].call(@object)
        if detail
          {:title => box_detail[:title], :value => detail}
        else
          nil
        end
      }
    @dls.compact!
    
    respond_to do |format|
      format.html { render(:nothing => true) }
      format.js { render :layout => false }
    end
  end
    
end