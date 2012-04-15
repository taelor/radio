class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper :all
  
  before_filter :recent_episodes
  
  protected
  
    def recent_episodes
      @recent_episodes = Episode.where{air_datetime < Date.today}.limit(6)
    end
end
