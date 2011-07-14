class EpisodesController < RadioController
  
  def script
    resource
    respond_to do |format|
      format.html { render :layout => false }
      format.pdf do 
        render(
          :pdf => resource.script_name, 
          :layout => false, 
          :header => {
            :left => "#{resource.live? ? 'LIVE': 'PRERECORD'} - #{resource.recording_datetime.to_date.to_s(:short)}\nGuest: #{resource.guest_name}",
            :right => "TECHTALK"
          },
          :footer => {
            :left => "IMI Group",
            :center => 'Page [page]/[topage]'
          }
        ) 
      end
    end
  end
  
  def email
    resource
  end
  
  protected
    
    def authorized?
      return true if ["index", "show"].include?(action_name) or current_user.admin? or current_user.host?
      authenticated_users = [ resource.guest ] + resource.guest.publicists
      return authenticated_users.include?(current_user)
    end
end
