class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable#, :registerable, :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :is_guest, :is_host, :is_admin, 
    :first_name, :last_name, :bio, :land_line_phone, :cell_phone
  
  scope :is_guest, where(:is_guest => true)
  scope :is_host, where(:is_host => true)
  
  def full_name
    "#{first_name} #{last_name}"
  end
  
  def is_host_or_admin?
    is_host? or is_admin?
  end
end
