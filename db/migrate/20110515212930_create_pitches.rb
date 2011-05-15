class CreatePitches < ActiveRecord::Migration
  def self.up
    create_table :pitches do |t|
      t.string :title
      t.string :contact_name
      t.string :contact_email
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :pitches
  end
end
