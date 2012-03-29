class Question < ActiveRecord::Base
  acts_as_list
  belongs_to :episode
end
