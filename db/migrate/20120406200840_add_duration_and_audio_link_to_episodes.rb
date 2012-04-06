class AddDurationAndAudioLinkToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :audio_link, :string

    add_column :episodes, :duration, :string

  end
end
