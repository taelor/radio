class ChangeBodyToTextField < ActiveRecord::Migration
  def self.up
    change_column :stories, :body, :text
  end

  def self.down
  end
end
