class AddIsPublicistToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :is_publicist, :boolean
  end

  def self.down
    remove_column :users, :is_publicist
  end
end
