module AuthorizedSystem
  
  class UnAuthorizedAction < StandardError; end
  
  protected
  
    def use_resource
    end
    
    def not_authorized_message(message="Not authorized")
      flash.now[:message] = message
    end    
    
    def login_required    
      authorized?(params[:controller], params[:action], use_resource) || 
      (not_authorized_message && access_denied)
    end
  
    def authorized?(controller=nil, action=nil, resource=nil, *args)
      logger.info "\nIn AuthorizedSystem"
      logger.info "Controller #{controller}"
      logger.info "Action #{action}"
      logger.info "Resource #{resource}"
      
      if logged_in?      
        if respond_to?("#{controller}_authorized?")
          return send("#{controller}_authorized?", action, resource)
        end        
        true
      else
        false
      end      
    end
    
   
end