class PostsController < ApplicationController
  before_action :set_post, only: [:show]
  before_action :set_user, only: %i[index show new]

  def index
    @posts = Post.all
  end

  def show; end

  def new
    @posts = Post.new
  end

  def create
    @posts = Post.new(post_params)
    @posts.author = current_user

    if @posts.save
      redirect_to user_posts_path(current_user, @posts), notice: 'Post was successfully created'
    else
      render :new, alert: 'post was not created.'
    end
  end

  def set_user
    @users = User.find(params[:user_id])
  end

  def set_post
    @posts = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
