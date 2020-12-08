class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def index
    @users = User.all
  end

  def show
    @user = User.find params[:id]
    @friends = User.where(id: @user.friends)
  end

  def make_friends
    @users = User.all
  end

  def find_experts
    @users = User.all
  end

end
