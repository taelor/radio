class AddIsGuestAndIsHostToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :is_host, :boolean
    add_column :users, :is_guest, :boolean
  end

  def self.down
    remove_column :users, :is_guest
    remove_column :users, :is_host
  end
end
