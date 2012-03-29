class StoriesController < RadioController
  def sort
    Story.find(params[:story]).each do |item|
      item.position = params['story'].index(item.id.to_s) + 1
      item.save
    end
    render :nothing => true
  end
end
