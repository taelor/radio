class QuestionsController < RadioController
  inherit_resources
  
  belongs_to :episode
end
