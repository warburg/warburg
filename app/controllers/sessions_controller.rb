# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
  skip_before_filter :login_required, :verify_authenticity_token
  
  @@openid_reqs = { 
    :required => [:email], 
    :optional => [:fullname, :dob, :gender, :postcode, :country, :language, :timezone]
                  }

  # render new.rhtml
  def new
    @text = Static.find_or_create_by_name("login").send("text_#{I18n.locale}")
  end

  def create
    open_id_authentication(params[:openid_url])
  end

  def destroy
    logout_killing_session!
    flash[:notice] = "You have been logged out."
    redirect_back_or_default('/')
  end
  
  protected
  
  def open_id_authentication(openid_url)
    authenticate_with_open_id(openid_url, @@openid_reqs) do |result, identity_url, registration|
      if result.successful?
        if !registration["email"].blank?
          user = User.find_or_create_by_identity_url(identity_url)
          user.update_attribute(:email, registration["email"])
          self.current_user = user
          successful_login
        else # registration["email"].blank?
          failed_login t('message.need_email')
        end
      else
        failed_login result.message
      end
    end
  end
    
  def password_authentication
    logout_keeping_session!
    user = User.authenticate(params[:login], params[:password])
    if user
      # Protects against session fixation attacks, causes request forgery
      # protection if user resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset_session
      self.current_user = user
      new_cookie_flag = (params[:remember_me] == "1")
      handle_remember_cookie! new_cookie_flag
      successful_login
    else
      @login       = params[:login]
      @remember_me = params[:remember_me]
      failed_login("Couldn't log you in as '#{params[:login]}'")
    end
  end

  private
  
  def successful_login
    logger.info "Successful login for '#{params[:login]}' or '#{params[:identity_url]}'"
    redirect_back_or_default(user_path(current_user))
    flash[:notice] = "Logged in successfully"
  end
  
  def failed_login(message)
    flash[:signin_error] = message
    # Track failed login attempts
    logger.warn "Failed login for '#{params[:login]}' or '#{params[:identity_url]}' from #{request.remote_ip} at #{Time.now.utc}"
    render :action => 'new'
  end
    
end
