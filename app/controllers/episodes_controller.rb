class EpisodesController < RadioController
  inherit_resources
  
  def script
    resource
    respond_to do |format|
      format.html { render :layout => false }
      format.pdf do 
        render(
          :pdf => resource.script_name, 
          :layout => false, 
          :header => {
            :left => "#{resource.live? ? 'LIVE': 'PRERECORD'} - #{resource.recording_datetime.to_date.to_s(:short)}",
            :center => "Guest: #{resource.guest_name}",
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
  
  def send_email
    resource
    if params[:email] == "script"
      pdf = render_to_string(
        :pdf => @episode.script_name,
        :template => 'episodes/script',
        :layout => false, 
        :header => {
          :left => "#{@episode.live? ? 'LIVE': 'PRERECORD'} - #{@episode.recording_datetime.to_date.to_s(:short)}",
          :center => "Guest: #{@episode.guest_name}",
          :right => "TECHTALK"
        },
        :footer => {
          :left => "IMI Group",
          :center => 'Page [page]/[topage]'
        }            
      )
      EpisodeMailer.send(params[:email], resource, pdf).deliver
    else
      EpisodeMailer.send(params[:email], resource).deliver
    end
    flash[:highlight] = "Email Delivered."
    render "email"
  end
  
  protected
    
    def authorized?
      return true if ["index", "show"].include?(action_name) or current_user.admin? or current_user.host?
      authenticated_users = [ resource.guest ] + resource.guest.publicists
      return authenticated_users.include?(current_user)
    end
end
