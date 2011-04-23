class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable#, :registerable, :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :is_guest, :is_host, :is_admin, 
    :first_name, :last_name, :bio, :land_line_phone, :cell_phone, :publicist_ids, :role_ids
    
  belongs_to :role
  
  
  
  has_many :guests_public_relationships,
    :class_name => "PublicRelationship",
    :foreign_key => :publicist_id
  has_many :guests, 
    :through => :guests_public_relationships  
  
    
  has_many :publicists_public_relationships,
    :class_name => "PublicRelationship",
    :foreign_key => :guest_id
  has_many :publicists, 
    :through => :publicists_public_relationships

  scope :admins, lambda { includes(:role).where("roles.name = 'Admin'") }
  scope :hosts, lambda { includes(:role).where("roles.name = 'Host'") }
  scope :guests, lambda { includes(:role).where("roles.name = 'Guest'") }
  scope :publicists, lambda { includes(:role).where("roles.name = 'Publicist'") }
  
  def full_name
    "#{first_name} #{last_name}"
  end
  
  def host_or_admin?
    role.host? or role.admin?
  end
  
  def host?
    role.host?
  end
  
  def admin?
    role.admin?
  end
  
  def guest?
    role.guest?
  end
  
  def publicist?
    role.publicist?
  end
  
end
