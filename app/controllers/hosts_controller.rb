class HostsController < RadioController
  inherit_resources
  
  defaults :resource_class => User, :collection_name => 'hosts', :instance_name => 'host'
  has_scope :is_host, :type => :boolean, :default => true
end
