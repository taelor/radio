class EpisodesController < RadioController
  
  protected
    
    def authorized?
      return true if action_name == "index" or current_user.admin? or current_user.host?
      authenticated_users = [ resource.guest ] + resource.guest.publicists
      return authenticated_users.include?(current_user)
    end
end
