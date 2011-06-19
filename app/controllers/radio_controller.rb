class RadioController < ApplicationController
  before_filter :authenticate_user!
  before_filter :redirect_if_not_authorized
  
  inherit_resources
  
  protected
  
    def authorized?
      if current_user.super_user?
        true
      else
        false
      end
    end
  
    def redirect_if_not_authorized
      if authorized?
        return true
      else
        flash[:error] = "You are not authorized to view that page or preform that action."
        redirect_to "/"
      end
    end
end
