class EpisodesController < RadioController
  inherit_resources
  
  respond_to :html, :pdf, :rss
  
  skip_before_filter :authenticate_user!, :only => [ :show, :index]
  
  def update
    update! do |success, failure|
      success.html { 
        expire_fragment('sidebar')
        redirect_to resource_path
      }
    end
  end
  
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
    generate_pdf if params[:email] == "script"
    EpisodeMailer.send(params[:email], resource).deliver
    flash[:highlight] = "Email Delivered."
    render "email"
  end
  
  protected
    
    def authorized?
      return true if ["index", "show"].include?(action_name) or current_user.admin? or current_user.host?
      authenticated_users = [ resource.guest ] + resource.guest.publicists
      return authenticated_users.include?(current_user)
    end
    
    def generate_pdf    
      pdf = render_to_string(
        :pdf => resource.script_name, 
        :template => "episodes/script",
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
      File.open(Rails.root.join('tmp', "#{resource.script_name}.pdf"), 'wb') do |file|
        file << pdf
      end
    end
    
end
