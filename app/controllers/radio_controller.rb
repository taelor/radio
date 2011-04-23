class RadioController < ApplicationController
  before_filter :authenticate_user!
  
  inherit_resources
end
