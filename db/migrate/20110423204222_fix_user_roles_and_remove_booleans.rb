class FixUserRolesAndRemoveBooleans < ActiveRecord::Migration
  def self.up
    User.all.each do |user|
      if user.is_admin?
        user.role = Role.find_by_name("Admin")
      elsif user.is_host?
        user.role = Role.find_by_name("Host")
      elsif user.is_guest?
        user.role = Role.find_by_name("Guest")
      elsif user.is_publicist?
        user.role = Role.find_by_name("Publicist")
      end
      user.save
    end
    
    remove_column :users, :is_admin
    remove_column :users, :is_host
    remove_column :users, :is_guest
    remove_column :users, :is_publicist
  end

  def self.down
  end
end
