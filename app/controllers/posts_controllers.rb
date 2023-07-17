class PostsController < ApplicationController
  before_action :set_post, only: [:show]

  def index
    @posts = Post.all
  end

  def show; end

  def set_post
    @posts = Post.find(params[:id])
  end
end
