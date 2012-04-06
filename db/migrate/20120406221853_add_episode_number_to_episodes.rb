class AddEpisodeNumberToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :episode_number, :integer

  end
end
