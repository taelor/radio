class TagsController < ApplicationController
  
  def index
    @tags = Episode.tag_counts.order("name")
  end
  
  def show
    @episodes = Episode.tagged_with(params[:name])
  end
end
