class EpisodesController < RadioController
  
  def script
    resource
    respond_to do |format|
      format.html { render :layout => false }
      format.pdf { render(:pdf => "script", :layout => false) }
    end
  end
  
  protected
    
    def authorized?
      return true if ["index", "show"].include?(action_name) or current_user.admin? or current_user.host?
      authenticated_users = [ resource.guest ] + resource.guest.publicists
      return authenticated_users.include?(current_user)
    end
end
