# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

module VtiController

  def show
    @object = admin? ? model_class.find(params[:id]) : model_class.visible.find(params[:id])

    if (controller_name == 'users') && !(admin? || (@object == current_user))
      redirect_to root_path
      return
    end

    respond_to do |format|
      format.html do
        @object.increment_view_counter_skip_stamp if @object.respond_to?("increment_view_counter_skip_stamp")
        render :template => 'main_klass/show'
      end
      format.xml  { render :xml => @object }
      format.rdf  { render :template => 'shared/show', :locals => {:object => @object} }
    end

# uncomment because the error handling changed to ApplicationController with custom 'error' layout

#  rescue ActiveRecord::RecordNotFound => e
#    render :file => "#{RAILS_ROOT}/public/404.html", :status => 404
#    return
  end

  def local_request? #:doc:
    admin? || RAILS_ENV == "development"
  end

  protected


  def main_classes
    Global.main_classes
  end

  def searchable_classes
    main_classes - 'seasons'
  end

  def help_classes
    Global.help_classes
  end

  def admin?
    current_user && current_user.admin?
  end

  def roles
    result = []
    if admin?
      result << :admin
    end
    result
  end

  def show_postits?
    current_user && (controller_name != 'tags')
  end

  def show_error_reports?
    current_user && (controller_name != 'tags')
  end

  def show_tags?
    @object.respond_to?('tag_list') && (logged_in? || !@object.tag_list.empty?)
  end

  # def default_url_options(options = nil)
  #   {:lang => params[:lang]}
  # end

  def available_locales
    %w(nl en fr)
  end

  def model_class_name
    controller_name.classify
  end

  def model_class
    if @model_class.nil?
      @model_class = eval(model_class_name)
    end
    @model_class
  end

  private

  def set_user_locale
    locale = I18n.locale = get_locale
    if current_user
      current_user.language = Language.find_by_locale(locale)
      current_user.save!
    end
    locale
  end

  def get_locale
    if available_locales.include?(params[:lang])
      session[:lang] = params[:lang]
    elsif session[:lang]
      session[:lang]
    elsif current_user && current_user.language
      current_user.language.to_locale
    else
      'nl'
    end
  end

  def default_login
    @current_user = User.find_by_email("koen@atog.be")
  end

end
