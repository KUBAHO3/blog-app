class LikesController < ApplicationController
  def create
    @like = Like.new
    @post = Post.find(params[:post_id])
    @like.post = @post
    @like.author = current_user

    if @like.save
      redirect_back(fallback_location: root_path, notice: 'Like was successfully created.')
    else
      render :new, alert: 'Like was not created.'
    end
  end
end
