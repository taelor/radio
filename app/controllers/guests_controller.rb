class GuestsController < RadioController
  defaults :resource_class => User, :collection_name => 'guests', :instance_name => 'guest'
  has_scope :is_guest, :type => :boolean, :default => true
end
