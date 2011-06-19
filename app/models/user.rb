class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  #:registerable, :trackable, :validatable :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :recoverable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :is_guest, :is_host, :is_admin, 
    :first_name, :last_name, :bio, :land_line_phone, :cell_phone, :publicist_ids, :guest_ids, :role_id, :role
    
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
    
  after_create :default_password_and_send_email

  scope :admins, lambda { includes(:role).where("roles.name = 'Admin'") }
  scope :hosts, lambda { includes(:role).where("roles.name = 'Host'") }
  scope :guests, lambda { includes(:role).where("roles.name = 'Guest'") }
  scope :publicists, lambda { includes(:role).where("roles.name = 'Publicist'") }
  
  def full_name
    "#{first_name} #{last_name}"
  end
  
  def super_user?
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
  
  def to_s
    "#{full_name} - #{role.to_s}"
  end
  
  def has_permission_to?(action, resource)
    return true if admin? or host?
    if resource.is_a?(Episode)
      if self.guest?
        return true if resource.guest == self 
      elsif self.publicist?
        return true if resource.publicists.include?(self)
      end
    end
    false
  end
  
  protected
    
    def default_password_and_send_email
      default_password = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{rand}--")[0,6]
      self.password = default_password
      self.password_confirmation = default_password
      self.save
      
      UserMailer.new_user_email(self, default_password).deliver
    end
end
