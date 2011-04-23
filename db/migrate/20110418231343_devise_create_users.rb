class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    null    = false
    default = ""

    add_column :users, :encrypted_password, :string, :null => null, :default => default, :limit => 128
    add_column :users, :password_salt, :string
    add_column :users, :authentication_token, :string
    add_column :users, :confirmation_token,   :string
    add_column :users, :confirmed_at,         :datetime
    add_column :users, :confirmation_sent_at, :datetime
    add_column :users, :reset_password_token, :string
    add_column :users, :remember_token,      :string
    add_column :users, :remember_created_at, :datetime
    add_column :users, :sign_in_count,      :integer, :default => 0
    add_column :users, :current_sign_in_at, :datetime
    add_column :users, :last_sign_in_at,    :datetime
    add_column :users, :current_sign_in_ip, :string
    add_column :users, :last_sign_in_ip,    :string

    #:lockable fields contributed by MattSlay
    add_column :users, :failed_attempts, :integer, :default => 0
    add_column :users, :unlock_token,   :string
    add_column :users, :locked_at, :datetime

    add_index :users, :reset_password_token, :unique => true
    add_index :users, :confirmation_token,   :unique => true
    add_index :users, :unlock_token,         :unique => true
    add_index :users, :authentication_token, :unique => true
  end

  def self.down
    drop_table :users
  end
end
