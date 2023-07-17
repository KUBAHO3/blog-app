class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def index
    @users = User.all
  end

  def show; end

  def set_user
    @users = User.find(params[:id])
  end
end
