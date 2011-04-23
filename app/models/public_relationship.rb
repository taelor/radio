class PublicRelationship < ActiveRecord::Base
  belongs_to :guest, :class_name => "User", :foreign_key => "guest_id"
  belongs_to :publicist, :class_name => "User", :foreign_key => "publicist_id"
end
