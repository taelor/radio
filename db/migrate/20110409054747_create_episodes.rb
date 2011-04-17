class CreateEpisodes < ActiveRecord::Migration
  def self.up
    create_table :episodes do |t|
      t.datetime :air_datetime
      t.datetime :recoding_datetime
      t.string :title
      t.integer :guest_id
      t.integer :host_id
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :episodes
  end
end
