class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string :name
    end
    
    #add_column :users, :role_id, :integer
    
    ["Admin", "Host", "Guest", "Publicist"].each do |role_name|
      Role.create(
        :name => role_name
      )
    end
    
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
  end

  def self.down
    drop_table :roles
    remove_column :users, :role_id
  end
end
