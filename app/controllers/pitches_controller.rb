class PitchesController < RadioController
  skip_before_filter :authenticate_user!, :only => :create
  
  
  def create
    create!{
      if current_user
        resource_path(resource)
      else
        contact_path
      end
    }
  end
  
  protected
    
    def authorized?
      if action_name == "create"
        true
      else
        super()
      end
    end
end
