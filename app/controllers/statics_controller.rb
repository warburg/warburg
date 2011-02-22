class StaticsController < ApplicationController
  include Userstamp

  def show
    if params[:id] == 'root'
      if current_user
        redirect_to user_path(current_user)
        return
      else
        params[:id] = 'about'
      end
    end
    @object = Static.find_or_create_by_name(params[:id])
    @text = @object.send("text_#{I18n.locale}")
  end

  def edit
    if admin?
      @object = Static.find_or_create_by_name(params[:id])
    else
      redirect_to root_path
    end
  end

  def update
    if admin?
      @object = Static.find_or_create_by_name(params[:id])
      @object.update_attributes(params[:static])
      redirect_to static_path(@object)
    else
      redirect_to root_path
    end
  end

  def robots
    respond_to do |format|
      format.txt { 
#        if RAILS_ENV == 'production'
#          render :text => ""
#        else
          render :text => "User-agent: *\nDisallow: /"
#        end
      }
    end
  end


end