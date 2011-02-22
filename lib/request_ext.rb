module ActionController
  class Request
    # Derive the classname of the resource from the request path.
    def resource_classname
      path.split('/')[1].classify
    end
  end
end