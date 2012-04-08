class TagsController < ApplicationController
  def show
    @episodes = Episode.tagged_with(params[:name])
  end
end
