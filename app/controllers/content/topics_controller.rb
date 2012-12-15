
class Content::TopicsController < Content::ContentController
  def index
    @vol = params[:id]
  end
end
