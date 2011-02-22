class PostitsController < DetailsController
  include Userstamp

  before_filter :login_required

  def add
    @postit = Postit.new(:text => params[:postit])
    @postit.user = current_user
    @postit.language = Language.find_by_locale(I18n.locale)
    @object = eval("#{params[:object]}.find(params[:id])")
    @postit.postitable = @object
    @postit.save!
    respond_to do |format|
      format.html { redirect_to(@object) }
      format.js { render :layout => false }
    end
  end

  def edit
    @postit = Postit.find(params["postit_id"])
    @postit.text = params[:postit]
    @postit.user = current_user
    @postit.language = Language.find_by_locale(I18n.locale)
    @postit.save!
    @object = eval("#{params[:object]}.find(params[:id])")
    respond_to do |format|
      format.html { redirect_to(@object) }
      format.js { render :layout => false }
    end
  end

  def destroy
    @postit = Postit.find(params[:id])
    if (@postit.user == current_user) || admin?
      @postit.destroy
      respond_to do |format|
        format.html { 
          @object = eval("#{params[:object_class]}.find(params[:object_id])")
          redirect_to(@object) }
        format.js { render :layout => false }
      end
    end
  end

end
