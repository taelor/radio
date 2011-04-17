class User < ActiveRecord::Base
  
  scope :is_guest, where(:is_guest => true)
  scope :is_host, where(:is_host => true)
  
  def full_name
    "#{first_name} #{last_name}"
  end
end
