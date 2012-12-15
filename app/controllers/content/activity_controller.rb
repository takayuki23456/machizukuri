class Content::ActivityController < Content::ContentController
  def top
    render :action=>:index
  end
  def index
    @vol = params[:id]
  rescue => e
    p e
    redirect_to(:action => 'top')
  end
  def movie
    @num = params[:id]
  end
end
