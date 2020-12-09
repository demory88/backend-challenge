class UsersController < ActionController::Base
  protect_from_forgery with: :exception

  layout "application"

  def index
    @users = User.all
  end

  def show
    @user = User.find params[:id]
    @users = User.all
    @friends = User.where(id: @user.friends)
  end

  def make_friends
    user = User.find params[:id]
    new_friends = params[:new_friends].reject { |f| f.empty? }
    user.friends = new_friends.map { |f| f.to_i }
    redirect_to :back, notice: "You made a new friend!"
  end

  def find_experts
    @users = User.all
  end

end
