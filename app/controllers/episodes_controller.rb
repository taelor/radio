class EpisodesController < RadioController
  
  def send_test_email
    EpisodeMailer.test_email.deliver
    redirect_to :episodes
  end
end
