# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  include VtiController

  include AuthenticatedSystem
  include AuthorizedSystem
  include Userstamp

  helper_method :default_url_options, :main_classes, 'admin?',
                :help_classes, 'show_postits?', 'show_tags?', 'show_error_reports?', :available_locales, :roles,
                :form_authenticity_token, :model_class_name

  helper_method :other_side_class if defined?(:other_side_class)

  protect_from_forgery # :secret => '82e80da8c756872e50adecfb7a9304c1'
  before_filter :default_login if RAILS_ENV == "development"

  before_filter :set_user_locale

  # Catching errors

  unless RAILS_ENV == "development"
    rescue_from StandardError, :with => :render_404
    rescue_from Exception, :with => :render_500
    rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  end

  def render_404
    render :template => "errors/error_404", :status => "404 Not Found", :layout => 'error'
    @error404 = "The page you were looking for doesn't exist (404)"
  end

  def render_500
    render :template => "errors/error_500", :status => "500 Not Found", :layout => 'error'
    @error500 = "We're sorry, but something went wrong (500)"
  end

end
