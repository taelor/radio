class RenameRecodingDatetimeToRecordingDatetimeOnEpisodes < ActiveRecord::Migration
  def self.up
    rename_column :episodes, :recoding_datetime, :recording_datetime
  end

  def self.down
    rename_column :episodes, :recording_dateime, :recoding_datetime
  end
end
