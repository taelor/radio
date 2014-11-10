class EpisodesController < RadioController
  inherit_resources
  
  has_scope :published
  has_scope :page, :default => 1
  
  respond_to :html, :pdf, :rss, :js
  
  skip_before_filter :authenticate_user!, :only => [ :show, :index]
  
  after_filter :expire_fragment_sidebar, :only => [ :create, :update, :destroy]
    
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
  
  def wordpress
    resource
    client_id       = "4321"
    client_secret   = "KLZMOtPtjt6iOq7LuEpNuEnClEYCBwnPpdysLQBgI5yKn03ZytAH74yX7vFnOjCs"
    site            = 'https://public-api.wordpress.com'
    redirect_uri    = "http://radio-director.heroku.com/wordpress/authorization"
    
    #attributes = {
    #  body: {
    #    client_id: client_id,
    #    redirect_uri: redirect_uri,
    #    response_type: "code"
    #  }
    #}
    #@response = HTTParty.post("https://public-api.wordpress.com/oauth2/authorize", attributes)
  end
  
  def publish_wordpress
    access_token = "#{ENV['WORDPRESS_API_KEY']}%Ui" 
    blog_id = "12483913" 
    
    attributes = {
      ignore_errors: "true",
      headers: {
        "authorization" => "Bearer #{access_token}"
      },
      body: params[:post]
    }
    @response = HTTParty.post( "https://public-api.wordpress.com/rest/v1/sites/#{blog_id}/posts/new",  attributes )
  end
  
  protected
  
    def collection
      @episodes = end_of_association_chain.published.page(params[:page]).includes(:tags, :guest)
    end
    
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
    
    def expire_fragment_sidebar
      expire_fragment('sidebar')
    end
    
end
