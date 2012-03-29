class QuestionsController < RadioController
  def sort
    Question.find(params[:question]).each do |item|
      item.position = params['question'].index(item.id.to_s) + 1
      item.save
    end
    render :nothing => true
  end
end
