class UsersController < ActionController::Base
  protect_from_forgery with: :exception

  layout "application"

  def index
    @users = User.all
  end

  def show
    @user = User.find params[:id]
    user = User.find params[:id]
    @friends = User.where(id: user.friends)
    remove = @user.friends << @user.id
    @all_users = User.where.not(id: remove)

    if params[:search].present?
      # do search stuff here
    end
  end

  def make_friends
    user = User.find params[:user]
    new_friends = params[:friend_list].reject { |f| f.empty? }
    user.friends = user.friends + new_friends.map { |f| f.to_i }
    user.save

    friends = User.where(id: user.friends)

    friends.each do |friend|
      friend.friends << user.id
      friend.friends.uniq
      friend.save
    end
    redirect_to :back, notice: "Your friends list is growing!"
  end

  def find_experts

    @users = User.all
  end

end
