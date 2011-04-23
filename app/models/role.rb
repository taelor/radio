class Role < ActiveRecord::Base
  
  def admin?
    name == "Admin"    
  end
  
  def host?
    name == "Host"    
  end
  
  def guest?
    name == "Guest"    
  end
  
  def publicist?
    name == "Publicist"    
  end
  
  def to_s
    name
  end
end
